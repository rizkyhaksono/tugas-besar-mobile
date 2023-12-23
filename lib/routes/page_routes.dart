import 'package:get/get.dart';
import 'package:push_puzzle/presentation/bndings/splash_binding.dart';
import 'package:push_puzzle/presentation/views/main_menu_view.dart';
import 'package:push_puzzle/presentation/views/splash_view.dart';
import 'package:push_puzzle/routes/page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 3000),
    ),
    GetPage(
      name: PageName.menu,
      page: () => MainMenuView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 3000),
    )
  ];
}
