import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/services/providers/theme_provider.dart';

void main() {
  testWidgets('Dark mode light mode icon changes correctly',
      (WidgetTester tester) async {
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
}
