import 'package:flutter/material.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

const double _size = 20;
const FontWeight _weight = FontWeight.w900;

class Entry {
  const Entry(this.title, this.controller, {this.hide = false});

  final String title;
  final TextEditingController controller;
  final bool hide;
}

class EntryField extends StatelessWidget {
  const EntryField(
    this.entry, {
    Key? key,
  }) : super(key: key);

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyText(
            entry.title,
            size: _size,
            weight: _weight,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: entry.hide,
            controller: entry.controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
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
      children: entries.map((Entry entry) => EntryField(entry)).toList(),
    );
  }
}
