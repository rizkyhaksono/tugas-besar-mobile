import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences _preferences;

  @override
  void onInit() async {
    super.onInit();
    _preferences = await SharedPreferences.getInstance();
    // Check if the user is already logged in
    bool isLoggedIn = _preferences.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Get.offAllNamed("/menu");
    }
  }

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
        _preferences.setBool('isLoggedIn', true);
        Get.offAllNamed("/menu");
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16.0),
          borderRadius: 8.0,
          isDismissible: true,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          shouldIconPulse: true,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
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
    _preferences.setBool('isLoggedIn', false);
    Get.offAllNamed("/signin");
  }
}
