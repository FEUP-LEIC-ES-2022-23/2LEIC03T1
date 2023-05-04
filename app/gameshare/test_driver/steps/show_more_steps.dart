import 'dart:ffi';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric goToGamePage() {
  return given< FlutterWorld>('I enter an game page',
      ( context) async {
    await FlutterDriverUtils.tap(context.world.driver, find.byValueKey('action1'));
    return;
  });
}
StepDefinitionGeneric shortenDescription() {
  return and< FlutterWorld>('The description is shorten',
          (context) async {
        final container= await find.byValueKey('mainText');
        String text= await FlutterDriverUtils.getText(context.world.driver!, find.descendant(of: container, matching: find.byType('Text')));
        context.expectMatch(text.length<=303, true);
        return;
      });
}

StepDefinitionGeneric clickInShowButton() {
  return when< FlutterWorld>('I click in the show button',
          (context) async {
            await context.world.driver!.scrollUntilVisible(find.byValueKey("ListView"),find.byValueKey('showButton'),alignment: 0.0,dxScroll: 0.0,dyScroll: -10,timeout: Duration(milliseconds: 100));
            await FlutterDriverUtils.tap(context.world.driver, find.byValueKey('showButton'));

            return;
      });
}
StepDefinitionGeneric descriptionShown() {
  return then1<String, FlutterWorld>('I should see the {String} description',
          (type,context) async {
            final container= find.byValueKey('mainText');
            String text= await FlutterDriverUtils.getText(context.world.driver!, find.descendant(of: container, matching: find.byType('Text')));
        if(type=="complete"){
          context.expectMatch(text.substring(text.length-3,text.length)=="...",false );
        }else{
          // await context.world.driver!.scroll(find.byValueKey("ListView"), 0, -150, Duration(milliseconds: 500));
          context.expectMatch(text.length<=303, true);
        }
        return;
      });
}





