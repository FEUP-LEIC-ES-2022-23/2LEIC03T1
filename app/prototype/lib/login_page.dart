import 'package:flutter/material.dart';
import 'package:prototype/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prototype/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage;
  bool isLoggingIn = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await Auth().signIn(
        emailController.text,
        passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUp() async {
    try {
      await Auth().signUp(
        emailController.text,
        passwordController.text,
      );
      errorMessage = null;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(title),
          TextField(
            style: const TextStyle(color: Colors.black),
            obscureText: isPassword,
            controller: isPassword ? passwordController : emailController,
            decoration: InputDecoration(
              errorText: errorMessage,
              border: InputBorder.none,
              fillColor: const Color(0xfff3f3f4),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField('Email'),
        _entryField('Password', isPassword: true),
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (isLoggingIn) {
          signIn();
        } else {
          signUp();
        }
        if (errorMessage == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffd9d9d9),
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff00bfa5),
              Color(0xff00acc1),
            ],
          ),
        ),
        child: Text(
          isLoggingIn ? 'Login' : 'Register',
          style: const TextStyle(
            fontSize: 20,
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

  Widget _toggleLogin() {
    return InkWell(
      onTap: () {
        setState(() {
          isLoggingIn = !isLoggingIn;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text(
          isLoggingIn ? 'Create Account' : 'Have an account? Login',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              _title('Login Page'),
              const SizedBox(
                height: 80,
              ),
              _emailPasswordWidget(),
              const SizedBox(
                height: 20,
              ),
              _errorMessage(),
              const SizedBox(
                height: 20,
              ),
              _submitButton(),
              const SizedBox(
                height: 20,
              ),
              _toggleLogin(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
