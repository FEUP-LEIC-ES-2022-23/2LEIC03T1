import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/components/helper_widgets.dart';

import '../components/nav_bar.dart';
import '../components/top_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Auth? auth, Key? key})
      : auth = auth ?? Auth(),
        super(key: key);

  final Auth? auth;
  Auth get authInstance => auth!;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _error;
  Auth get _auth => widget.authInstance;

  final Entry _email = Entry('Email', TextEditingController());
  final Entry _username = Entry('Username', TextEditingController());
  final Entry _password =
      Entry('Password', TextEditingController(), hide: true);
  final Entry _confirmPassword =
      Entry('Confirm Password', TextEditingController(), hide: true);

  final List<Entry> _entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    _entries.add(_email);
    _entries.add(_username);
    _entries.add(_password);
    _entries.add(_confirmPassword);
  }

  Future<void> _signUp() async {
    bool res = await _auth.signUpEmailPassword(
      _email.controller.text,
      _username.controller.text,
      _password.controller.text,
    );
    if (!res) {
      setState(() => _error = 'Invalid field');
    } else {
      setState(() => _error = null);
    }
  }

  Future<void> signUp() async {
    if (_password.controller.text != _confirmPassword.controller.text) {
      setState(() => _error = 'Passwords do not match');
      return;
    }

    await _signUp();
    if (_auth.user != null) _goToHome();
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

  void _goToLogin() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => LoginPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Widget _loginLabel() {
    return InkWell(
      onTap: _goToLogin,
      child: const MyLabel('Already have an account', left: true, size: 15),
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
