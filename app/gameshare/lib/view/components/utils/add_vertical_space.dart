import 'package:flutter/material.dart';

class addVerticalSpace extends StatelessWidget {
  const addVerticalSpace({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
