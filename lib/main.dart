import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/routes/page_names.dart';
import 'package:push_puzzle/routes/page_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Crate Man',
      initialRoute: PageName.splash,
      getPages: PageRoutes.pages,
    );
  }
}
