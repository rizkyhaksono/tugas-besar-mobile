import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/main_menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainMenuController());
  }
}
