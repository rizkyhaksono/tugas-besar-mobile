import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';
import 'package:push_puzzle/constants/resources.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(currentUser),
                  const SizedBox(height: 1),
                  _buildListItem(
                    Icons.person,
                    'Username: ${getUserDisplayName(currentUser)}',
                  ),
                  _buildListItem(
                    Icons.exit_to_app,
                    'Logout',
                    textColor: Colors.red,
                    onTap: () async {
                      await _authService.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.account_circle,
          color: Resources.color.primaryBg,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildHeader(User? currentUser) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Resources.color.primaryBg,
          radius: 40,
          child: const Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 56,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hello, ${getUserDisplayName(currentUser)}!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: Resources.font.primaryFont,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _buildListItem(
    IconData icon,
    String text, {
    Color? textColor,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontFamily: Resources.font.primaryFont,
        ),
      ),
      onTap: onTap,
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
