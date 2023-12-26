import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
  }
}
