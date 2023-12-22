import 'package:flutter/material.dart';
import 'package:push_puzzle/main_menu_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Crate Man',
      home: MainMenuPage(),
    );
  }
}
