import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed("/menu");
    });
  }
}
