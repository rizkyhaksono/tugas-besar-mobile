import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/presentation/controllers/signin_controller.dart';
import 'package:push_puzzle/presentation/views/signin_view.dart';
import '../firebase_mock.dart';

void main() async {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('SignInView widget test', (WidgetTester tester) async {
    Get.put(SignInController());
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SignInView(),
      ),
    );

    expect(find.text('Let us sign you in!'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));

    await tester.pump();

    await tester.tap(find.text('Sign In'));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump();
  });
}
