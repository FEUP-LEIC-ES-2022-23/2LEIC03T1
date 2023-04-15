import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/main.dart';

import 'package:gameshare/view/screens/login.dart';

void main() {
  testWidgets('Login screen has expected text', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Navigate to the login screen
    await tester.tap(find.byIcon(Icons.person));

    // Trigger a frame
    await tester.pump();

    // Verify text
    expect(find.text("GAMESHARE"), findsOneWidget);
    expect(find.text('Email/Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Don\'t have an account? Create one'), findsOneWidget);
    expect(find.text('Boas'), findsNothing);
  });
}
