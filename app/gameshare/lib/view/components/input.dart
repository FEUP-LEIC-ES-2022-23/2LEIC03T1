import 'package:flutter/material.dart';
import 'package:gameshare/view/components/helper_widgets.dart';

const double _size = 20;
const FontWeight _weight = FontWeight.w900;

void goTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ____) => page,
      transitionDuration: const Duration(seconds: 0),
    ),
  );
}

class Entry {
  const Entry(this.key, this.title, this.controller, {this.hide = false});

  final String key;
  final String title;
  final TextEditingController controller;
  final bool hide;
}

class EntryField extends StatelessWidget {
  const EntryField(
    this.entry, {
    this.lines = 1,
    Key? key,
  }) : super(key: key);

  final Entry entry;
  final int lines;

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
            maxLines: lines,
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
      children: entries
          .map((Entry entry) => EntryField(
                entry,
                key: Key(entry.key),
              ))
          .toList(),
    );
  }
}

class UserDataForm extends StatelessWidget {
  const UserDataForm(
    this.widgets, {
    Key? key,
  }) : super(key: key);

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
