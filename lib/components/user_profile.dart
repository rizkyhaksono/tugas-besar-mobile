import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';

class UserProfile extends StatelessWidget {
  final AuthService _authService = AuthService();

  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        User? currentUser = await _authService.getCurrentUser();

        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Username: ${getUserDisplayName(currentUser)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(height: 1, color: Colors.grey),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  onTap: () async {
                    await _authService.signOut();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle,
          color: Colors.blue,
          size: 28,
        ),
      ),
    );
  }

  String getUserDisplayName(User? user) {
    if (user != null) {
      if (user.providerData.isNotEmpty) {
        if (user.providerData[0].providerId == 'google.com') {
          return user.displayName ?? 'N/A';
        } else {
          return user.email?.split('@')[0] ?? 'N/A';
        }
      }
    }
    return 'N/A';
  }
}
