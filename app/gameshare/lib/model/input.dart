import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gameshare/view/screens/home.dart';

TextStyle _font = GoogleFonts.montserratAlternates();
const double _titleSize = 30;
const FontWeight _titleWeight = FontWeight.w900;

class Entry {
  const Entry(this.title, this.controller, {this.hide = false});

  final String title;
  final TextEditingController controller;
  final bool hide;
}

Widget _title(String title) {
  return Text(
    title,
    style: _font.copyWith(
      fontSize: _titleSize,
      fontWeight: _titleWeight,
    ),
  );
}

Widget text(String text,
    {double size = 16, FontWeight weight = FontWeight.w400, Color? color}) {
  return Text(
    text,
    style: _font.copyWith(
      fontSize: size,
      fontWeight: weight,
      color: color,
    ),
  );
}

Widget _entryField(Entry entry) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _title(entry.title),
        const SizedBox(height: 20),
        TextField(
          style: const TextStyle(color: Colors.black),
          obscureText: entry.hide,
          controller: entry.controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
        ),
      ],
    ),
  );
}

Widget entryFieldList(List<Entry> entries) {
  return Column(
    children: entries.map((Entry entry) => _entryField(entry)).toList(),
  );
}

Widget whitespace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget label(String text_, Function() onTap, {bool left = true}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      child: text(
        text_,
        size: 16,
        weight: FontWeight.w800,
        color: const Color(0xff5E5BFF),
      ),
    ),
  );
}

Widget displayError(String? error) {
  return text(
    error ?? '',
    size: 13,
    color: Colors.red,
  );
}

Widget submitButton(
    String text_, String? error, Function() onTap, BuildContext context) {
  return InkWell(
    onTap: () async {
      error = null;
      await onTap();
      if (error == null && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xff00FFDD),
            Color(0xff00ddff),
          ],
        ),
      ),
      child: text(
        text_,
        size: 20,
        weight: FontWeight.w800,
        color: Colors.white,
      ),
    ),
  );
}
