import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'steps/auth_steps.dart';
import 'steps/navbar_steps.dart';
import 'steps/dark_light_mode/given.dart';
import 'steps/dark_light_mode/tap_on_button.dart';
import 'steps/dark_light_mode/theme_change.dart';
import 'steps/show_more_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [RegExp('test_driver/features/*.*.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..hooks = []
    ..stepDefinitions = [
      inLoginPage(),
      fillInField(),
      tapButton(),
      seeHomePage(),
      seeError(),
      inRegisterPage(),
      goToPage(),
      switchPage(),
      checkPage(),
      EnterApp(),
      TapButtonNTimesStep(),
      ThemeChange(),
      fillInAdminFields(),
      seeUserPage(),
      goToGamePage(),
      shortenDescription(),
      clickInShowButton(),
      descriptionShown(),

    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}
