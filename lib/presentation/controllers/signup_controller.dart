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
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    final user = await _authService.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      Get.toNamed('/sigin');
    } else {
      Get.snackbar('Error', 'Failed to sign up');
    }
  }
}
