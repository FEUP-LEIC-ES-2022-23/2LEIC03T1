import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/services/utils.dart';

void main() {
  testWidgets('Html transforms html elements', (WidgetTester tester) async {
    String text = "<p>Hello<br />World</p>";
    expect(Html(text), " Hello\nWorld ");
  });
  testWidgets('Html removes unknown elements', (WidgetTester tester) async {
    String text = "<Section>Hello<header />World</Section></?/>";
    expect(Html(text), " Hello World  ");
  });
  testWidgets('Html replaces elements and special chars elements',
      (WidgetTester tester) async {
    String text = "Hello&#39;Worldâ";
    expect(Html(text), "Hello'World’");
  });
}
