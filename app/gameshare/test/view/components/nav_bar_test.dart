import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/view/components/nav_bar.dart';

void main() {
  testWidgets("NavBar has the correct components", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}
