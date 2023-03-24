import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gameshare/main.dart';
import 'package:gameshare/providers/themeProvider.dart';

void darkLightMode() {
  testWidgets('Dark mode light mode icon changes correctly', (
      WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_outlined), findsNothing);
    expect(ThemeProvider().isDarkMode(), false);
    expect(ThemeProvider().themeMode, ThemeMode.light);


    await tester.tap(find.byIcon(Icons.light_mode_outlined));
    await tester.pump();


    expect(find.byIcon(Icons.light_mode_outlined), findsNothing);
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    expect(ThemeProvider().isDarkMode(), true);
    expect(ThemeProvider().themeMode, ThemeMode.dark);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pump();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_outlined), findsNothing);
    expect(ThemeProvider().isDarkMode(), false);
    expect(ThemeProvider().themeMode, ThemeMode.light);
  });
  testWidgets('toggle changes the isDark and theme value', (
      WidgetTester tester) async {

    ThemeProvider themeProvider= ThemeProvider();
    expect(themeProvider.themeMode, ThemeMode.light);
    expect(themeProvider.isDarkMode(), false);
    themeProvider.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.dark);
    expect(themeProvider.isDarkMode(), true);
    themeProvider.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.light);
    expect(themeProvider.isDarkMode(), false);
  });
  testWidgets('All ThemeProviders provide the same ThemePreference', (
      WidgetTester tester) async {
        ThemeProvider themeProvider1=ThemeProvider();
        ThemeProvider themeProvider2=ThemeProvider();
        expect(themeProvider1.themePrefs, themeProvider2.themePrefs);
        themeProvider1.toggleTheme();
        expect(themeProvider1.themeMode, themeProvider2.themeMode);
        expect(themeProvider1.isDarkMode(), themeProvider2.isDarkMode());
  });
}