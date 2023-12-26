import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/auth_service.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool obscurePassword = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password is empty!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16.0),
        borderRadius: 8.0,
        isDismissible: true,
      );
      return;
    }

    final user = await _authService.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      Get.toNamed('/sigin');
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
  }
}
