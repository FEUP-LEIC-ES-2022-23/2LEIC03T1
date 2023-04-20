import 'dart:convert';

String Html(String html) {
  String withBreaks = html.replaceAll("<br />", '\n');
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  String withoutElements = withBreaks.replaceAll(exp, ' ');
  String withApostrophe = withoutElements.replaceAll("&#39;", "'");
  const utf = Utf8Decoder();

  String withoutSpecialChars = utf.convert(withApostrophe.runes.toList());
  return withoutSpecialChars;
}
