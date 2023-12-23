import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/signin_controller.dart';

class SignInView extends GetView {
  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Show email/password sign-in form
              },
              child: Text('Sign In with Email/Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await signInController.signInWithGoogle();
              },
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
