import 'package:flutter/material.dart';

class RectangleWithText extends StatelessWidget {
  const RectangleWithText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.all(20),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
        ));
  }
}
