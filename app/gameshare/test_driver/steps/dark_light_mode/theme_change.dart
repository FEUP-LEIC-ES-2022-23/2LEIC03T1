import 'package:flutter/material.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_driver/flutter_driver.dart' as finder;
import 'package:gameshare/consts/theme_data.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/services/providers/theme_provider.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric ThemeChange() {
  return then1<String, FlutterWorld>('I switch to the {String}.',
      (theme, context) async {
    final expectMatch = context.expectMatch;
    if (theme == "light") {
      final button = finder.find.byValueKey("lightMode");
      expectMatch(
          await FlutterDriverUtils.isPresent(context.world.driver, button),
          true);
    } else {
      final button = finder.find.byValueKey("darkMode");
      expectMatch(
          await FlutterDriverUtils.isPresent(context.world.driver, button),
          true);
    }
  });
}
