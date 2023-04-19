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

StepDefinitionGeneric fillInEmail() {
  return given1<String, FlutterWorld>(
    'I fill in email with {string}',
    (email, context) async {
      final emailField = find.byValueKey('email_field_login');
      await FlutterDriverUtils.enterText(
        context.world.driver,
        emailField,
        email,
      );
    },
  );
}

StepDefinitionGeneric fillInPassword() {
  return given1<String, FlutterWorld>(
    'I fill in password with {string}',
    (password, context) async {
      final passwordField = find.byValueKey('password_field_login');
      await FlutterDriverUtils.enterText(
        context.world.driver,
        passwordField,
        password,
      );
    },
  );
}

StepDefinitionGeneric tapLoginButton() {
  return when1<String, FlutterWorld>(
    'I tap the {string} button',
    (text, context) async {
      final loginButton = find.text(text);
      await FlutterDriverUtils.tap(context.world.driver, loginButton);
    },
  );
}

StepDefinitionGeneric seeHomePage() {
  return then<FlutterWorld>(
    'I should see the home page',
    (context) async {
      // We will need to refactor our code to make this work
      // Probably we'll have to use a class for the current page
      // And the LoginPage Notifies observers that the page should be changed
      // And the NavBar listens to the LoginPage and changes the page

      //final homePage = find.byType('HomePage');
      //context.expectMatch(
      //await FlutterDriverUtils.isPresent(context.world.driver, homePage),
      //true,
      //);

      final finder = find.text('GAMESHARE');
      context.expectMatch(
        await FlutterDriverUtils.isPresent(context.world.driver, finder),
        true,
      );
    },
  );
}

StepDefinitionGeneric seeError() {
  return then1<String, FlutterWorld>(
    'I should see {string}',
    (error, context) async {
      final finder = find.text(error);
      context.expectMatch(
        await FlutterDriverUtils.isPresent(context.world.driver, finder),
        true,
      );
    },
  );
}
