import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/model/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage;

  bool _rememberMe = false;
  final Entry user = Entry('Email/Username', TextEditingController());
  final Entry password = Entry('Password', TextEditingController(), hide: true);
  final List<Entry> entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    entries.add(user);
    entries.add(password);
  }

  Future<void> signIn() async {
    try {
      await Auth().signInEmailPassword(
        user.controller.text,
        password.controller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        errorMessage = null;
        await signIn();
        if (errorMessage == null && context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff00FFDD),
              Color(0xff00ddff),
            ],
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'MontserratAlternates',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    if (errorMessage != null) {
      return Text(
        errorMessage!,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 13,
        ),
      );
    } else {
      return const SizedBox();
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
        child: const Text(
          'Forgot Password ?',
          style: TextStyle(
            fontFamily: 'MontserratAlternates',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xff5E5BFF),
          ),
        ),
      ),
    );
  }

  Widget _rememberMeBox() {
    return Row(
      children: <Widget>[
        const Text(
          'Remember me',
          style: TextStyle(
            fontFamily: 'MontserratAlternates',
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        // checkbox
        Checkbox(
          value: _rememberMe,
          onChanged: (bool? value) {
            setState(() => _rememberMe = value!);
          },
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerLeft,
        child: const Text(
          "Don't have an account? Create one",
          style: TextStyle(
            fontFamily: 'MontserratAlternates',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xff5E5BFF),
          ),
        ),
      ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              whitespace(200),
              entryFieldList(entries),
              _forgotPassword(),
              whitespace(20),
              _errorMessage(),
              whitespace(20),
              _submitButton(),
              whitespace(30),
              _rememberMeBox(),
              whitespace(20),
              _createAccountLabel(),
            ],
          ),
        ),
      ),
    );
  }
}
