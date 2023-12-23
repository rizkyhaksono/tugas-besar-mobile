import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Resources.color.primaryBg,
      child: Column(
        children: [
          Flexible(
              child: Column(
            children: [
              Text('Splash Screen'),
            ],
          ))
        ],
      ),
    );
  }
}
