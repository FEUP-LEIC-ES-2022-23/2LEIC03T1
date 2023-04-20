import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
          scale: 2,
          child: const CircularProgressIndicator(
            strokeWidth: 1.5,
          )),
    );
  }
}
