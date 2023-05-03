import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gameshare/services/auth.dart';
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

StepDefinitionGeneric fillInField() {
  return given2<String, String, FlutterWorld>(
    'I fill in {string} with {string}',
    (key, value, context) async {
      final field = find.byValueKey(key);
      await FlutterDriverUtils.enterText(
        context.world.driver,
        field,
        value,
      );
    },
  );
}
StepDefinitionGeneric fillInAdminFields() {
  return given2<String, String, FlutterWorld>(
    'I fill in {string} with my {string}',
        (key, value, context) async {
      final field = find.byValueKey(key);
      await dotenv.load(fileName: ".env");
      if(value=="email") {
        value=dotenv.env['ADMIN_EMAIL']??"";
      } else if(value=="password") {
        value=dotenv.env['ADMIN_PASSWORD']??"";
      }
      await FlutterDriverUtils.enterText(
        context.world.driver,
        field,
        value,
      );
    },
  );
}

StepDefinitionGeneric tapButton() {
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

StepDefinitionGeneric inRegisterPage() {
  return given<FlutterWorld>(
    'I am in the register page',
    (context) async {
      final goToLogin = find.text('User');

      await FlutterDriverUtils.tap(context.world.driver, goToLogin);
      final goToRegister = find.text("Don't have an account? Create one");
      await FlutterDriverUtils.tap(context.world.driver, goToRegister);
      final registerButton = find.text('Register');
      context.expectMatch(
        await FlutterDriverUtils.isPresent(
            context.world.driver, registerButton),
        true,
      );
    },
  );
}
StepDefinitionGeneric seeUserPage() {
  return then<FlutterWorld>(
    'I should see my user page',
        (context) async {
          await dotenv.load(fileName: ".env");
          // print(dotenv.env['ADMIN_EMAIL']);
          sleep(Duration(seconds: 2));
      final finder = await find.byValueKey(dotenv.env['ADMIN_EMAIL']);
      context.expectMatch(
        await FlutterDriverUtils.isPresent(context.world.driver, finder),
        true,
      );
    },
  );
}

