import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      isLoading.value = true;
      var user = await _authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      isLoading.value = false;

      if (user != null) {
        Get.offAllNamed("/menu");
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor:
              Colors.green, // Customize the background color for success
          colorText: Colors.white, // Customize the text color
          duration: Duration(seconds: 3), // Specify the duration
          snackPosition:
              SnackPosition.BOTTOM, // Position the snack bar at the bottom
          margin: EdgeInsets.all(16.0), // Add some margin for better spacing
          borderRadius: 8.0, // Apply border radius for rounded corners
          isDismissible:
              true, // Allow dismissing by tapping outside the snack bar
          icon: const Icon(Icons.check_circle,
              color: Colors.white),
          shouldIconPulse: true, 
          mainButton: TextButton(
            onPressed: () {
              print("test");
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          'Email and password are not correct!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16.0),
          borderRadius: 8.0,
          isDismissible: true,
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
        Get.offAllNamed("/menu");
        print(
            'User signed in with Google: ${userCredential.user?.displayName}');
      } else {
        print('Google sign-in canceled');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed("/signin");
  }
}
