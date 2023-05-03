import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/login.dart';

import '../../mocks.dart';

void main() {
  testWidgets('Login screen has expected text', (WidgetTester tester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));

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
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));

    expect(find.byType(InkWell), findsWidgets);
    expect(find.byType(MyCheckBox), findsOneWidget);
    expect(find.byType(EntryFieldList), findsOneWidget);
  });

  // This can't currently be tested because a private method is used
  // to change the screen. That method then pushes a RegisterPage
  // which depends on Firebase. Since Firebase is not initialized
  // in the test, the app crashes.
  // testWidgets('Screen changes on button press', (WidgetTester tester) async {});

  testWidgets('Authentication should work as expected', (widgetTester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    final MockUser user = MockUser();
    final Finder emailField = find.byType(EntryField).at(0);
    final Finder passwordField = find.byType(EntryField).at(1);
    final Finder loginButton = find.text('Login');

    await widgetTester.pumpWidget(MaterialApp(home: LoginPage(auth: auth)));

    await widgetTester.enterText(emailField, 'good_email');
    await widgetTester.enterText(passwordField, 'good_pwd');
    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    expect(find.text("Invalid email or password"), findsNothing);
    expect(user, isNotNull);

    await widgetTester.enterText(emailField, "bad_email");
    await widgetTester.enterText(passwordField, "bad_pwd");
    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    expect(find.text("Invalid email or password"), findsOneWidget);
  });
}
