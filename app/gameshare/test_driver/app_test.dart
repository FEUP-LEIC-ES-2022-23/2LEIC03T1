import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'steps/steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('test_driver/features/[a-zA-Z_]+.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = [
      inLoginPage(),
      fillInEmail(),
      fillInPassword(),
      tapLoginButton(),
      seeHomePage(),
      seeError(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}
