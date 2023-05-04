import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:gameshare/services/auth.dart';

import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/register.dart';

import '../../mocks.dart';

void main() {
  testWidgets('Register screen has expected text', (WidgetTester tester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: RegisterPage(auth: auth)));

    expect(find.text("GAMESHARE"), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Already have an account'), findsOneWidget);
    expect(find.text('Boas'), findsNothing);
  });

  testWidgets('Register has expected buttons', (WidgetTester tester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    await tester.pumpWidget(MaterialApp(home: RegisterPage(auth: auth)));

    expect(find.byType(InkWell), findsWidgets);
    expect(find.byType(EntryFieldList), findsOneWidget);
  });

  // This can't currently be tested because a private method is used
  // to change the screen. That method then pushes a LoginPage
  // which depends on Firebase. Since Firebase is not initialized
  // in the test, the app crashes.
  // testWidgets('Screen changes on button press', (WidgetTester tester) async {});

  testWidgets('Authentication should work as expected', (widgetTester) async {
    final MockAuth auth = MockAuth(auth: MockFirebaseAuth());
    final MockUser user = MockUser();
    await widgetTester.pumpWidget(MaterialApp(home: RegisterPage(auth: auth)));
    final Finder emailField = find.byType(EntryField).at(0);
    final Finder usernameField = find.byType(EntryField).at(1);
    final Finder passwordField = find.byType(EntryField).at(2);
    final Finder confirmPasswordField = find.byType(EntryField).at(3);
    final Finder registerButton = find.text('Register');
    await widgetTester.tap(registerButton);
    await widgetTester.pumpAndSettle();
    expect(find.text("Fields cannot be empty"), findsOneWidget);
    await widgetTester.enterText(emailField, "bad_email");
    await widgetTester.enterText(usernameField, "bad_username");
    await widgetTester.enterText(passwordField, "bad_pwd");
    await widgetTester.enterText(confirmPasswordField, "bad_pwd");
    await widgetTester.tap(registerButton);
    await widgetTester.pumpAndSettle();
    expect(find.text("Email is not valid"), findsOneWidget);
    await widgetTester.enterText(emailField, "good_email");
    await widgetTester.enterText(usernameField, "good_username");
    await widgetTester.enterText(passwordField, "good_pwd");
    await widgetTester.enterText(confirmPasswordField, "good_pwd");
    await widgetTester.tap(registerButton);
    await widgetTester.pumpAndSettle();
    expect(find.text("Email is not valid"), findsNothing);
    expect(user, isNotNull);
  });
}
