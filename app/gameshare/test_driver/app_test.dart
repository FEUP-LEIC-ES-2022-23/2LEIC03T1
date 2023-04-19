import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/dark_light_mode/given.dart';
import 'steps/dark_light_mode/tap_on_button.dart';
import 'steps/dark_light_mode/theme_change.dart';



Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features =  [Glob(r'test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json'),
    ]
    ..stepDefinitions = [
      EnterApp(),
      TapButtonNTimesStep(),
      ThemeChange(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
  return GherkinRunner().execute(config);
}