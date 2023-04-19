import 'package:flutter/material.dart';

class LeftCenteredTitle extends StatelessWidget {
  const LeftCenteredTitle({
    super.key,
    required this.text,
    required this.textSize,
  });

  final double textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
