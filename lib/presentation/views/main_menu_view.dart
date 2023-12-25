import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'main_game_view.dart';

class MainMenuView extends GetView {
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
            UserCircleAvatar(),
            SizedBox(width: 8),
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
          ],
        ),
      ),
    );
  }
}

class UserCircleAvatar extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Fetch the current user
        User? currentUser = await _authService.getCurrentUser();

        // Show the modal bottom sheet
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Username: ${currentUser?.displayName ?? "N/A"}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  onTap: () async {
                    // Logout logic
                    await _authService.signOut();

                    // Close the bottom sheet
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle,
          color: Colors.blue,
          size: 28,
        ),
      ),
    );
  }
}
