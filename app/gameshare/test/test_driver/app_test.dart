import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'steps/dark_light_mode/tap_on_button.dart';
import 'steps/dark_light_mode/theme_change.dart';

import 'package:glob/glob.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r'test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = [TapButtonNTimesStep(), ThemeChange()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}