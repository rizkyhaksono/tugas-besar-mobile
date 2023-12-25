import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/signin_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
