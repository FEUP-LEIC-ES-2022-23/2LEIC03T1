import 'package:flutter/material.dart';

class RectangleWithText extends StatelessWidget {
  const RectangleWithText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
        ));
  }
}
