import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/signin_controller.dart';

class SignInView extends GetView {
  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      appBar: AppBar(backgroundColor: Resources.color.primaryBg),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: signInController.emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Resources.color.crateBox,
              style: TextStyle(color: Resources.color.crateBox),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Resources.color.crateBox, fontSize: 18),
                hintText: 'Enter your email',
                hintStyle:
                    TextStyle(color: Resources.color.crateBox.withOpacity(0.6)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Resources.color.crateBox),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Resources.color.crateBox),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Resources.color.crateBox,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: signInController.passwordController,
              obscureText: true,
              cursorColor: Resources.color.crateBox,
              style: TextStyle(color: Resources.color.crateBox),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Resources.color.crateBox, fontSize: 20),
                hintText: 'Enter your password',
                hintStyle:
                    TextStyle(color: Resources.color.crateBox.withOpacity(0.6)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Resources.color.crateBox),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Resources.color.crateBox,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: signInController.signInWithEmailAndPassword,
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await signInController.signInWithGoogle();
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/google-icon.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
