import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/main.dart';
import 'package:push_puzzle/presentation/views/main_menu_view.dart';
import '../test/firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();

  testWidgets('Main menu view test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    Get.to(const MainMenuView());

    await tester.pumpAndSettle();

    expect(find.text('Push Crate Man'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
    expect(find.text('News'), findsOneWidget);
    expect(find.text('Exit'), findsOneWidget);

    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();

    expect(find.text('Game Screen'), findsOneWidget);
  });
}