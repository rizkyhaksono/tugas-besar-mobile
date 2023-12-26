import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsController());
  }
}
