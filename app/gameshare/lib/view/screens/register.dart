import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/model/input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage;

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

  Future<void> signIn() async {
    try {
      await Auth().signInEmailPassword(
        email.controller.text,
        password.controller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    }
  }

  Future<void> signUp() async {
    if (password.controller.text != confirmPassword.controller.text) {
      setState(() => errorMessage = 'Passwords do not match');
      return;
    }
    try {
      await Auth().signUpEmailPassword(
        email.controller.text,
        password.controller.text,
      );
      errorMessage = null;
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        errorMessage = null;
        await signUp();
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
          'Register',
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

  Widget _loginPageLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: const Text(
          "Already have an account? Login",
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
              whitespace(100),
              entryFieldList(entries),
              whitespace(20),
              _errorMessage(),
              whitespace(20),
              _submitButton(),
              whitespace(20),
              _loginPageLabel(),
            ],
          ),
        ),
      ),
    );
  }
}
