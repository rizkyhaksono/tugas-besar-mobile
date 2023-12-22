import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:push_puzzle/utils/resources.dart';
import 'main_game_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      appBar: AppBar(
        backgroundColor: Resources.color.primaryBg,
        title: Text(
          'Push Crate Man',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Resources.font.primaryFont,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainGamePage(),
                  ),
                );
              },
              child: Text(
                'Start Game',
                style: TextStyle(
                  color: Resources.color.crateBox,
                  fontFamily: Resources.font.primaryFont,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                'Exit',
                style: TextStyle(
                  color: Resources.color.crateBox,
                  fontFamily: Resources.font.primaryFont,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
