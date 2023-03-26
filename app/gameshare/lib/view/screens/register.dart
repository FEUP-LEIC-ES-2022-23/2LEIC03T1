import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/model/input.dart';
import 'package:gameshare/view/screens/home.dart';

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

  final List<Entry> entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    entries.add(email);
    entries.add(username);
    entries.add(password);
    entries.add(confirmPassword);
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

    if (_error == null && context.mounted) {
      _goToHome(context);
    }
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
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Widget _loginLabel() {
    return label(
      "Already have an account? Login",
      () => _goToLogin(context),
      left: false,
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () => signUp(),
      child: submitButton('Register', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            entryFieldList(entries),
            whitespace(20),
            displayError(_error),
            whitespace(10),
            _registerButton(),
            whitespace(20),
            _loginLabel(),
          ],
        ),
      ),
    );
  }
}
