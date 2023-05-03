import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric goToPage() {
  return given1<String, FlutterWorld>('I am on the {String} page',
      (page, context) async {
    if (page == "Home")
      await FlutterDriverUtils.tap(context.world.driver, find.text('Home'));
    else if (page == "Search")
      await FlutterDriverUtils.tap(context.world.driver, find.text('Search'));
    else if (page == "Login") {
      await FlutterDriverUtils.tap(context.world.driver, find.text("User"));
    }

    context.expectMatch(
      await FlutterDriverUtils.isPresent(
          context.world.driver, find.byValueKey(page)),
      true,
    );
  });
}

StepDefinitionGeneric switchPage() {
  return when1<String, FlutterWorld>('I click on the {String} Button on NavBar',
      (page, context) async {
    final icon = find.text(page);
    await FlutterDriverUtils.tap(context.world.driver, find.text(page));
  });
}

StepDefinitionGeneric checkPage() {
  return then1<String, FlutterWorld>('I am on the top of {String} Page',
      (page, context) async {
    context.expectMatch(
      await FlutterDriverUtils.isPresent(
          context.world.driver, find.byValueKey(page)),
      true,
    );
  });
}
