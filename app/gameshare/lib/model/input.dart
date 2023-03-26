import 'package:flutter/material.dart';
import 'package:gameshare/model/helper_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

const double _size = 30;
const FontWeight _weight = FontWeight.w900;

class Entry {
  const Entry(this.title, this.controller, {this.hide = false});

  final String title;
  final TextEditingController controller;
  final bool hide;
}

Widget _entryField(Entry entry) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MyText(entry.title, size: _size, weight: _weight),
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

class EntryFieldList extends StatelessWidget {
  const EntryFieldList(
    this.entries, {
    Key? key,
  }) : super(key: key);

  final List<Entry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries.map((Entry entry) => _entryField(entry)).toList(),
    );
  }
}
