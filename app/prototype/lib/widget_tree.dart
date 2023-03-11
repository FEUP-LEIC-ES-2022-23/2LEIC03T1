import 'package:flutter/material.dart';
import 'package:prototype/auth.dart';
import 'package:prototype/user.dart';
import 'package:prototype/login_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) return const UserScreen();
          return const LoginPage();
        });
  }
}
