import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gameshare/services/providers/theme_provider.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric EnterApp() {
  return given<FlutterWorld>('I enter the app', (context) async {
    return;
  });
}
