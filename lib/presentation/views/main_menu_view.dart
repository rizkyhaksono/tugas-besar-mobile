import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/components/dot_menu.dart';
import 'package:push_puzzle/components/user_profile.dart';
import 'package:push_puzzle/constants/resources.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  print("news");
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
            ),
          ],
        ),
      ),
    );
  }
}
