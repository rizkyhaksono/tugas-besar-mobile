import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      isLoading.value = true;
      var user = await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      isLoading.value = false;

      if (user != null) {
        // Navigate to the next screen or perform other actions
      } else {
        Get.dialog(
          AlertDialog(
            title: Text('Sign In Failed'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the alert
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        // Successful sign-in, perform actions like navigation or user feedback
        print(
            'User signed in with Google: ${userCredential.user?.displayName}');
      } else {
        // User canceled the sign-in
        print('Google sign-in canceled');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // Additional sign-out logic if needed
  }
}
