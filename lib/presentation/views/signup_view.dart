import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            Obx(
              () => TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.togglePasswordVisibility();
                    },
                    child: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: controller.obscurePassword.value,
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.toNamed("signin");
              },
              child: Text("Have an account? Sign in here"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => controller.signUp(),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
