import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/components/dot_menu.dart';
import 'package:push_puzzle/components/user_profile.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      appBar: AppBar(
        backgroundColor: Resources.color.primaryBg,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserProfile(),
            Text(
              'Push Crate Man',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: Resources.font.primaryFont,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const TripleDotPopupMenu(),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed("/game");
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
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // controller.showLeaderboard();
                      Get.toNamed("/leaderboard");
                    },
                    child: Text(
                      'Leaderboard',
                      style: TextStyle(
                        color: Resources.color.crateBox,
                        fontFamily: Resources.font.primaryFont,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/news");
                    },
                    child: Text(
                      'News',
                      style: TextStyle(
                        color: Resources.color.crateBox,
                        fontFamily: Resources.font.primaryFont,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      _showExitConfirmationDialog();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Exit Confirmation',
            style: TextStyle(
              fontFamily: Resources.font.primaryFont,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to exit?',
            style: TextStyle(
              fontFamily: Resources.font.primaryFont,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: Resources.font.primaryFont,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                'Exit',
                style: TextStyle(
                  fontFamily: Resources.font.primaryFont,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
