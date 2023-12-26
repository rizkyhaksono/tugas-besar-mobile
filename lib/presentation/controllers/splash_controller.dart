import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;
  var isButtonEnabled = false.obs;

  final List<String> splashData = [
    'Welcome to Puzzle App\nEmbark on a journey of mind-bending challenges and immersive fun. Unleash your inner puzzle solver!',
    'Discover Amazing Features\nExplore a world of captivating puzzles and unlock hidden treasures. Our app is packed with unique and exciting challenges.',
    'Enjoy Using the App\nImmerse yourself in a seamless and delightful puzzle-solving experience. From novices to experts, everyone can savor the joy of accomplishment.',
  ];

  final List<String> imagesAssets = [
    "assets/images/splash1.png",
    "assets/images/splash2.png",
    "assets/images/splash3.png"
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page?.round() ?? 0;
      isButtonEnabled.value = currentPage.value == splashData.length - 1;
    });
  }

  void goToSignIn() {
    if (isButtonEnabled.value) {
      Get.offAllNamed("/signin");
    }
  }

  void setPage(int index) {
    currentPage.value = index;
    isButtonEnabled.value = index == splashData.length - 1;
  }
}
