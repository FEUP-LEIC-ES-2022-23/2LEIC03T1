import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/components/helper_widgets.dart';

import '../components/nav_bar.dart';
import '../components/top_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _error;

  final Entry email = Entry('Email', TextEditingController());
  final Entry username = Entry('Username', TextEditingController());
  final Entry password = Entry('Password', TextEditingController(), hide: true);
  final Entry confirmPassword =
      Entry('Confirm Password', TextEditingController(), hide: true);

  final List<Entry> _entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    _entries.add(email);
    _entries.add(username);
    _entries.add(password);
    _entries.add(confirmPassword);
  }

  Future<void> _signUp() async {
    try {
      await Auth().signUpEmailPassword(
        email.controller.text,
        username.controller.text,
        password.controller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> signUp() async {
    if (password.controller.text != confirmPassword.controller.text) {
      setState(() => _error = 'Passwords do not match');
      return;
    }

    setState(() => _error = null);

    await _signUp();

    if (_error == null && context.mounted) _goToHome(context);
  }

  void _goToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => LoginPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Widget _loginLabel() {
    return InkWell(
      onTap: () => _goToLogin(context),
      child: const MyLabel(
        'Already have an account',
        left: true,
        size: 15,
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () => signUp(),
      child: SubmitButton('Register', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EntryFieldList(_entries),
                DisplayError(_error),
                const WhiteSpace(),
                _registerButton(),
                _loginLabel(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
