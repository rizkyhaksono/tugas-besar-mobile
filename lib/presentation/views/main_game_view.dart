import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';

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
      ],
    ));
  }

  Widget buildPauseButton() {
    return Positioned(
      top: 16,
      right: 16,
      child: ElevatedButton(
        onPressed: () {
          showPauseModal();
        },
        child: Text('Pause Game'),
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
          title: Text('Game Paused'),
          content: Text('Do you want to resume the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Resume'),
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed("/menu");
              },
              child: Text('Main Menu'),
            ),
          ],
        );
      },
    );
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
