import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/model/input.dart';
import 'package:gameshare/view/screens/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _error;

  final Entry user = Entry('Email/Username', TextEditingController());
  final Entry password = Entry('Password', TextEditingController(), hide: true);
  final List<Entry> entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    entries.add(user);
    entries.add(password);
  }

  Future<void> _signIn() async {
    try {
      await Auth().signInEmailPassword(
        user.controller.text,
        password.controller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> signIn(BuildContext context) async {
    setState(() => _error = null);

    await _signIn();

    if (_error == null && context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Widget _forgotPassword() {
    return InkWell(
      onTap: () {
        // TODO: Forgot Password
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: text(
          'Forgot Password?',
          size: 16,
          weight: FontWeight.w800,
          color: const Color(0xff5E5BFF),
        ),
      ),
    );
  }

  Widget _rememberMeBox() {
    return Row(
      children: <Widget>[
        text(
          'Remember me',
          size: 18,
          weight: FontWeight.w800,
        ),
        const MyCheckBox(),
      ],
    );
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const RegisterPage(),
      ),
    );
  }

  Widget _createAccountLabel() {
    return label(
      "Don't have an account? Create one",
      () => _goToRegister(),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () => signIn(context),
      child: submitButton('Login', context),
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
            _forgotPassword(),
            whitespace(20),
            displayError(_error),
            whitespace(20),
            _loginButton(),
            whitespace(30),
            _rememberMeBox(),
            whitespace(20),
            _createAccountLabel(),
          ],
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _rememberMe,
      onChanged: (bool? value) => setState(() => _rememberMe = value!),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
