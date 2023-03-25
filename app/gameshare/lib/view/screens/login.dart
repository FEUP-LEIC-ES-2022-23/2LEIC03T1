import 'package:flutter/material.dart';

import '../components/NavBar.dart';
import '../components/TopBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: TopBar(),

      body: Text("It's time to log in!"),

      bottomNavigationBar: NavBar(),

    );
  }
}
