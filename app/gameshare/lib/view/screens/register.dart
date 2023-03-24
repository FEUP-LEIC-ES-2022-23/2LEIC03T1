import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage;

  bool _selectedRememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signIn() async {
    try {
      await Auth().signInEmailPassword(
        userController.text,
        passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    }
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() => errorMessage = 'Passwords do not match');
      return;
    }
    try {
      await Auth().signUpEmailPassword(
        emailController.text,
        passwordController.text,
      );
      errorMessage = null;
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    }
  }

  Widget _title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'MontserratAlternates',
        fontSize: 30,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(title),
          const SizedBox(height: 20),
          TextField(
            style: const TextStyle(color: Colors.black),
            obscureText: isPassword,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paramsWidget() {
    return Column(
      children: <Widget>[
        _entryField('Email', emailController),
        _entryField('Username', userController),
        _entryField('Password', passwordController, isPassword: true),
        _entryField('Confirm Password', confirmPasswordController,
            isPassword: true),
      ],
    );
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

  Widget _rememberMe() {
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
          value: _selectedRememberMe,
          onChanged: (bool? value) {
            setState(() => _selectedRememberMe = value!);
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

  Widget _whitespace(double height) {
    return SizedBox(
      height: height,
    );
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
              _whitespace(100),
              _paramsWidget(),
              _whitespace(20),
              _errorMessage(),
              _whitespace(20),
              _submitButton(),
              _whitespace(20),
              _loginPageLabel(),
            ],
          ),
        ),
      ),
    );
  }
}
