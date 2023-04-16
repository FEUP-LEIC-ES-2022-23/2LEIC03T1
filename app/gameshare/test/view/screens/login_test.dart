import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:mockito/mockito.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}

class MockAuthenticator extends Mock {
  void signInEmailPassword(String? email, String? password);
}

void main() {
  testWidgets('Login screen has expected text', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(find.text("GAMESHARE"), findsOneWidget);
    expect(find.text('Email/Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Don\'t have an account? Create one'), findsOneWidget);
    expect(find.text('Boas'), findsNothing);
  });

  testWidgets('Login screen has expected buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    expect(find.byType(InkWell), findsWidgets);
    expect(find.byType(MyCheckBox), findsOneWidget);
    expect(find.byType(EntryFieldList), findsOneWidget);
  });

  testWidgets('Screen changes to register screen on button press',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestApp());

    await tester.tap(find.text('Don\'t have an account? Create one'));
    await tester.pumpAndSettle();

    expect(find.text('Register'), findsOneWidget);
  });
}
