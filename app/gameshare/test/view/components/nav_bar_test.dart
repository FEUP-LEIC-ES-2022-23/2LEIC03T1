import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/view/components/nav_bar.dart';


void main() {
  testWidgets("NavBar has the correct components", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byKey(Key("Home")), findsOneWidget);
    expect(find.byKey(Key("Search")), findsOneWidget);
    expect(find.byKey(Key("User")), findsOneWidget);
  });
  
}