import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
