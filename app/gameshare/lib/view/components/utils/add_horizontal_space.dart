import 'package:flutter/material.dart';

class addHorizontalSpace extends StatelessWidget {
  const addHorizontalSpace({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
