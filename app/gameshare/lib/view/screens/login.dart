import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import '../components/nav_bar.dart';
import '../components/top_bar.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _error;

  final Entry _user = Entry('Email/Username', TextEditingController());
  final Entry _password =
      Entry('Password', TextEditingController(), hide: true,);
  final List<Entry> _entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    _entries.add(_user);
    _entries.add(_password);
  }

  Future<void> _signIn() async {
    try {
      await Auth().signInEmailPassword(
        _user.controller.text,
        _password.controller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> signIn() async {
    setState(() => _error = null);

    await _signIn();

    if (_error == null && context.mounted) _goToHome();
  }

  void _goToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => const RegisterPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  void _goToHome() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => const HomePage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {
        // TODO: Forgot Password
      },
      child: const MyLabel('Forgot Password?', left: false,size: 15),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: _goToRegister,
      child: const MyLabel("Don't have an account? Create one",size: 15,),
    );
  }

  Widget _rememberMeBox() {
    return Row(
      children:  <Widget>[
        MyText('Remember me', size: 15, weight: FontWeight.w800,color: Theme.of(context).primaryColor,),
        MyCheckBox(),
      ],
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () => signIn(),
      child: SubmitButton('Login', context),
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
                _forgotPasswordLabel(),
                DisplayError(_error),

                _loginButton(),
                const WhiteSpace(),
                _rememberMeBox(),

                _createAccountLabel(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),

    );
  }
}
