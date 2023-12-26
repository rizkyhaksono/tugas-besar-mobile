import 'package:get/get.dart';
import 'package:push_puzzle/presentation/bndings/news_binding.dart';
import 'package:push_puzzle/presentation/bndings/signin_binding.dart';
import 'package:push_puzzle/presentation/bndings/signup_binding.dart';
import 'package:push_puzzle/presentation/bndings/splash_binding.dart';
import 'package:push_puzzle/presentation/views/about_view.dart';
import 'package:push_puzzle/presentation/views/contact_view.dart';
import 'package:push_puzzle/presentation/views/credit_view.dart';
import 'package:push_puzzle/presentation/views/main_game_view.dart';
import 'package:push_puzzle/presentation/views/main_menu_view.dart';
import 'package:push_puzzle/presentation/views/news_view.dart';
import 'package:push_puzzle/presentation/views/signin_view.dart';
import 'package:push_puzzle/presentation/views/signup_view.dart';
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
      name: PageName.signIn,
      page: () => SignInView(),
      binding: SignInBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.signUp,
      page: () => SignUpView(),
      binding: SignUpBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.menu,
      page: () => MainMenuView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.news,
      page: () => NewsView(),
      binding: NewsBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.game,
      page: () => MainGameView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.credit,
      page: () => CreditView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.about,
      page: () => AboutView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: PageName.contact,
      page: () => ContactView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    )
  ];
}
