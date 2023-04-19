import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric inLoginPage() {
  return given<FlutterWorld>(
    'I am in the login page',
    (context) async {
      final goToLogin = find.text('User');
      await FlutterDriverUtils.tap(context.world.driver, goToLogin);
      final loginButton = find.text('Login');
      context.expectMatch(
        await FlutterDriverUtils.isPresent(context.world.driver, loginButton),
        true,
      );
    },
  );
}
