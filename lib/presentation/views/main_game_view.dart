import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/utils/direction.dart';

import 'game.dart';

class MainGameView extends StatefulWidget {
  const MainGameView({Key? key}) : super(key: key);

  @override
  MainGameViewState createState() => MainGameViewState();
}

class MainGameViewState extends State<MainGameView> {
  MainGame game = MainGame();
  bool _isClear = false;

  @override
  Widget build(BuildContext context) {
    game.setCallback(_changeState);

    return Scaffold(
        body: Stack(
      children: [
        GameWidget(game: game),
        Congratulations(isClear: _isClear),
        buildPauseButton(),
        buildNavigationButtons(),
      ],
    ));
  }

  Widget buildPauseButton() {
    return Positioned(
      top: 40,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          showPauseModal();
        },
        child: Icon(
          Icons.menu,
          color: Resources.color.crateBox,
          size: 20,
        ),
      ),
    );
  }

  void _changeState(state) {
    setState(() {
      _isClear = state;
    });
  }

  void showPauseModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Paused'),
          content: const Text('Do you want to resume the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Resume'),
            ),
            TextButton(
              onPressed: () async {
                Get.offAllNamed("/menu");
                await FlameAudio.bgm.stop();
              },
              child: const Text('Main Menu'),
            ),
          ],
        );
      },
    );
  }

  Widget buildNavigationButtons() {
    return Positioned(
      bottom: 20,
      left: 20,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _movePlayer(Direction.up);
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _movePlayer(Direction.left);
                },
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _movePlayer(Direction.right);
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _movePlayer(Direction.down);
                },
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _movePlayer(Direction direction) {
    game.movePlayer(direction);
  }
}

class Congratulations extends StatelessWidget {
  final bool isClear;
  const Congratulations({Key? key, required this.isClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.6),
      child: Visibility(
        visible: isClear,
        child: Image.asset('assets/images/congratulations.png'),
      ),
    );
  }
}
