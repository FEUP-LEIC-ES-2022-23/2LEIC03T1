import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/services/providers/theme_provider.dart';

void main() {
  testWidgets("TopBar has the correct components", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byKey(Key("Logo")), findsOneWidget);
    expect(
        find.byIcon(ThemeProvider().isDarkMode()
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
        findsOneWidget);
    expect(find.text("GAMESHARE"), findsOneWidget);
    expect(find.text("LOGO"), findsNothing);
  });
}
