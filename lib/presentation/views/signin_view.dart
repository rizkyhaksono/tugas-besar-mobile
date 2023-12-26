import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Let us sign you in!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: Resources.font.primaryFont,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Resources.color.primaryBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: Resources.font.primaryFont,
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontFamily: Resources.font.primaryFont,
                  fontSize: 14,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: const Icon(Icons.email, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: Resources.font.primaryFont,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontFamily: Resources.font.primaryFont,
                    fontSize: 14,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.togglePasswordVisibility();
                    },
                    child: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.toNamed("/signup");
              },
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: DefaultTextStyle.of(context).style.copyWith(
                        color: Colors.white60,
                        fontSize: 12,
                        fontFamily: Resources.font.primaryFont,
                        decoration: TextDecoration.none,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up here!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontFamily: Resources.font.primaryFont,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: Get.width / 3,
              child: ElevatedButton(
                onPressed: controller.signInWithEmailAndPassword,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: Resources.font.primaryFont,
                    color: Resources.color.crateBox,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.signInWithGoogle();
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
