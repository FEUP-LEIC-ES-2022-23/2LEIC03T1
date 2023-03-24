import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/screens/login.dart';

const String _font = 'MontserratAlternates';
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
    style: const TextStyle(
      fontFamily: _font,
      fontSize: _titleSize,
      fontWeight: _titleWeight,
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
