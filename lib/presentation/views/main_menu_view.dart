import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/components/user_profile.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'main_game_view.dart';

class MainMenuView extends GetView<MenuController> {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      appBar: AppBar(
        backgroundColor: Resources.color.primaryBg,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            UserProfile(),
            const SizedBox(width: 8),
            Text(
              'Push Crate Man',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Resources.font.primaryFont,
                color: Colors.white,
              ),
            ),
          ],
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
                    builder: (context) => const MainGameView(),
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
            ElevatedButton(
              onPressed: () async {
                // controller.playMusic();
                // Get.to(AudioPlayerUrl());
              },
              child: Text("Click me"),
            )
          ],
        ),
      ),
    );
  }
}
