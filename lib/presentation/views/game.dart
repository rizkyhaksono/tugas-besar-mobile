import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/effects/provider_interfaces.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/main_menu_controller.dart';
import 'package:push_puzzle/utils/sound_local.dart';

import '../../components/player.dart';
import '../../components/crate.dart';

import 'dart:async';

import '../../src/push_game.dart';
import '../../utils/config.dart';
import '../../utils/direction.dart';

class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
  MainMenuController controller = MainMenuController();
  late Function stateCallbackHandler;

  late Timer _timer;

  late TextComponent _timerText;

  PushGame pushGame = PushGame();
  late Player _player;
  final List<Crate> _crateList = [];
  final List<SpriteComponent> _bgComponentList = [];
  final List<SpriteComponent> _floorSpriteList = [];
  late Map<String, Sprite> _spriteMap;
  late Sprite _floorSprite;

  @override
  Color backgroundColor() => const Color.fromRGBO(89, 106, 108, 1.0);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final blockSprite = await Sprite.load('block.png');
    final goalSprite = await Sprite.load('goal.png');
    _floorSprite = await Sprite.load('floor.png');
    _spriteMap = {
      '#': blockSprite,
      '.': goalSprite,
    };

    camera = CameraComponent();

    await draw();
    startTimer();

    _timerText = TextComponent(
      text: 'Time: ${controller.remainingTimeInSeconds}',
    )
      ..anchor = Anchor.topLeft
      ..x = 10
      ..y = 10;
    add(_timerText);
  }

  void setCallback(Function fn) => stateCallbackHandler = fn;

  void restartGame() {
    controller.remainingTimeInSeconds = 300;
    _timer.cancel();
    startTimer();
    allReset();
    draw();

    _timerText = TextComponent(
      text: 'Time: ${controller.remainingTimeInSeconds}',
    )
      ..anchor = Anchor.topLeft
      ..x = 10
      ..y = 10;
    add(_timerText);
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (controller.remainingTimeInSeconds > 0) {
          controller.remainingTimeInSeconds--;
          _timerText.text = 'Time: ${controller.remainingTimeInSeconds}';
        } else {
          _timer.cancel();
          Get.dialog(
            barrierDismissible: true,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Material(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "Game Over",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: Resources.font.primaryFont,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Wanna start again?",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(0, 45),
                                      backgroundColor:
                                          Resources.color.primaryBg,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      _timer.cancel();
                                      Get.back();
                                      await FlameAudio.bgm.stop();
                                    },
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Resources.font.primaryFont,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(0, 45),
                                      backgroundColor:
                                          Resources.color.primaryBg,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      restartGame();
                                      Get.back();
                                    },
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Resources.font.primaryFont,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> draw() async {
    for (var y = 0; y < pushGame.state.splitStageStateList.length; y++) {
      final row = pushGame.state.splitStageStateList[y];
      final firstWallIndex = row.indexOf('#');
      final lastWallIndex = row.lastIndexOf('#');

      for (var x = 0; x < row.length; x++) {
        final char = row[x];
        if (x > firstWallIndex && x < lastWallIndex)
          renderFloor(x.toDouble(), y.toDouble());
        if (_spriteMap.containsKey(char))
          renderBackGround(_spriteMap[char], x.toDouble(), y.toDouble());
        if (char == 'p') initPlayer(x.toDouble(), y.toDouble());
        if (char == 'o') initCrate(x.toDouble(), y.toDouble());
      }
    }

    add(_player);
    for (var crate in _crateList) {
      add(crate);
    }

    if (pushGame.state.width > playerCameraWallWidth) {
      camera.follow(_player);
    } else {
      final targetPosition = Vector2(
        pushGame.state.width * oneBlockSize / 2,
        pushGame.state.height * oneBlockSize / 2,
      );
      camera.follow(Vector2PositionProvider(targetPosition));
    }
  }

  void renderBackGround(sprite, double x, double y) {
    final component = SpriteComponent(
      size: Vector2.all(oneBlockSize),
      sprite: sprite,
      position: Vector2(x * oneBlockSize, y * oneBlockSize),
    );
    _bgComponentList.add(component);
    add(component);
  }

  void renderFloor(double x, double y) {
    final component = SpriteComponent(
      size: Vector2.all(oneBlockSize),
      sprite: _floorSprite,
      position: Vector2(x * oneBlockSize, y * oneBlockSize),
    );
    _floorSpriteList.add(component);
    add(component);
  }

  void initPlayer(double x, double y) {
    _player = Player();
    _player.position = Vector2(x * oneBlockSize, y * oneBlockSize);
  }

  void initCrate(double x, double y) {
    final crate = Crate();
    crate.setPosition(Vector2(x, y));
    crate.position = Vector2(x * oneBlockSize, y * oneBlockSize);
    _crateList.add(crate);
  }

  void allReset() {
    remove(_player);
    for (var crate in _crateList) {
      remove(crate);
    }
    for (var bg in _bgComponentList) {
      remove(bg);
    }
    for (var floorSprite in _floorSpriteList) {
      remove(floorSprite);
    }
    _crateList.clear();
    _bgComponentList.clear();
    _floorSpriteList.clear();
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction keyDirection = Direction.none;

    if (!isKeyDown || _player.moveCount != 0 || pushGame.state.isClear) {
      return super.onKeyEvent(event, keysPressed);
    }

    keyDirection = getKeyDirection(event);
    bool isMove = pushGame.changeState(keyDirection.name);
    if (isMove) {
      playerMove(isKeyDown, keyDirection);
      if (pushGame.state.isCrateMove) {
        createMove();
      }
      if (pushGame.state.isClear) {
        stateCallbackHandler(pushGame.state.isClear);
        Timer(const Duration(seconds: 3), drawNextStage);
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  Direction getKeyDirection(RawKeyEvent event) {
    Direction keyDirection = Direction.none;
    if (event.logicalKey == LogicalKeyboardKey.keyA ||
        event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD ||
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      keyDirection = Direction.down;
    }
    return keyDirection;
  }

  void playerMove(bool isKeyDown, Direction keyDirection) {
    if (isKeyDown && keyDirection != Direction.none) {
      _player.direction = keyDirection;
      _player.moveCount = oneBlockSize.toInt();
    } else if (_player.direction == keyDirection) {
      _player.direction = Direction.none;
    }
  }

  void createMove() {
    final targetCrate = _crateList.firstWhere(
        (crate) => crate.coordinate == pushGame.state.crateMoveBeforeVec);
    targetCrate.move(pushGame.state.crateMoveAfterVec);
    targetCrate.goalCheck(pushGame.state.goalVecList);
  }

  void drawNextStage() {
    controller.remainingTimeInSeconds = 300;
    pushGame.nextStage();
    stateCallbackHandler(pushGame.state.isClear);
    allReset();
    draw();

    _timer.cancel();
    startTimer();

    _timerText = TextComponent(
      text: 'Time: ${controller.remainingTimeInSeconds}',
    )
      ..anchor = Anchor.topLeft
      ..x = 10
      ..y = 10;
    add(_timerText);
  }

  void movePlayer(Direction direction) {
    if (_player.moveCount == 0 && !pushGame.state.isClear) {
      bool isMove = pushGame.changeState(direction.name);
      if (isMove) {
        playerMove(true, direction);
        if (pushGame.state.isCrateMove) {
          createMove();
        }
        if (pushGame.state.isClear) {
          stateCallbackHandler(pushGame.state.isClear);
          Timer(const Duration(seconds: 3), drawNextStage);
        }
      }
    }
  }
}

class Vector2PositionProvider implements ReadOnlyPositionProvider {
  final Vector2 _position;

  Vector2PositionProvider(this._position);

  Vector2 getPosition() => _position;

  @override
  Vector2 get position => _position;
}
