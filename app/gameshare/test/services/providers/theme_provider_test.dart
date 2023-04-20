import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/services/providers/theme_provider.dart';

void main() {
  testWidgets('toggle changes the isDark and theme value',
      (WidgetTester tester) async {
    ThemeProvider themeProvider = ThemeProvider();
    expect(themeProvider.themeMode, ThemeMode.light);
    expect(themeProvider.isDarkMode(), false);
    themeProvider.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.dark);
    expect(themeProvider.isDarkMode(), true);
    themeProvider.toggleTheme();
    expect(themeProvider.themeMode, ThemeMode.light);
    expect(themeProvider.isDarkMode(), false);
  });
  testWidgets('All ThemeProviders provide the same ThemePreference',
      (WidgetTester tester) async {
    ThemeProvider themeProvider1 = ThemeProvider();
    ThemeProvider themeProvider2 = ThemeProvider();
    expect(themeProvider1.themePrefs, themeProvider2.themePrefs);
    themeProvider1.toggleTheme();
    expect(themeProvider1.themeMode, themeProvider2.themeMode);
    expect(themeProvider1.isDarkMode(), themeProvider2.isDarkMode());
  });
}
