import 'package:flutter/material.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart' ;
import 'package:gameshare/services/providers/theme_provider.dart';
import 'package:gherkin/gherkin.dart';


StepDefinitionGeneric ThemeChange() {
  return then1<String, FlutterWorld>(
    'I switch to the {String}.',
        (theme, context) async {
      if(theme=="light"){
        final button= find.byIcon((Icons.light_mode_outlined));
        expect(button, findsOneWidget);
        ThemeProvider themeProvider= ThemeProvider();
        expect(themeProvider.themeMode, ThemeMode.light);
        expect(themeProvider.isDarkMode(), false);
      }
      else{
        final button= find.byIcon((Icons.dark_mode_outlined));
        expect(button, findsOneWidget);
        ThemeProvider themeProvider= ThemeProvider();
        expect(themeProvider.themeMode, ThemeMode.dark);
        expect(themeProvider.isDarkMode(), true);
      }
    },
  );
}