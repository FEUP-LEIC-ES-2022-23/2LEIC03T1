import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric TapButtonNTimesStep() {
  return when1<int, FlutterWorld>(
    'I tap on the mode icon {int} time',
        (count, context) async {
      final locator = find.byValueKey(Icon(Icons.light_mode_outlined));
      for (var i = 0; i < count; i += 1) {
        await FlutterDriverUtils.tap(context.world.driver, locator);
      }
    },
  );
}