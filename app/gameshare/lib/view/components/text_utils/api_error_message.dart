import 'package:flutter/material.dart';

class APIErrorMessage extends StatelessWidget {
  final String errMessage;

  const APIErrorMessage({
    super.key,
    required this.errMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errMessage,
          style: const TextStyle(
            color: Color(0xffa92113),
            fontSize: 20,
          )),
    );
  }
}
