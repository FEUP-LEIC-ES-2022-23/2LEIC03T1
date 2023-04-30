import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/view/screens/forgot_password.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/screens/user.dart';
import '../components/nav_bar.dart';
import '../components/top_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Auth? auth, Key? key})
      : auth = auth ?? Auth(),
        super(key: key);

  final Auth? auth;
  Auth get authInstance => auth!;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _error;

  Auth get _auth => widget.authInstance;

  final Entry user = Entry(
        'email_field_login',
        'Email/Username',
        TextEditingController(),
      ),
      password = Entry(
        'password_field_login',
        'Password',
        TextEditingController(),
        hide: true,
      );

  final List<Entry> _entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    _entries.add(user);
    _entries.add(password);
  }

  Future<void> signIn() async {
    String res = await _auth.signInEmailPassword(
      user.controller.text,
      password.controller.text,
    );
    if (res == _auth.success) {
      _goToUser();
    } else {
      setState(() {
        _error = res;
      });
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => RegisterPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  void _goToUser() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => const UserPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => ForgotPasswordPage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Widget _rememberMeBox() {
    return Row(
      children: <Widget>[
        MyText(
          'Remember me',
          size: 15,
          weight: FontWeight.w800,
          color: Theme.of(context).primaryColor,
        ),
        const MyCheckBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Login'),
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
                TapLabel('Forgot Password?', _goToForgotPassword),
                const WhiteSpace(height: 20),
                DisplayError(_error),
                const WhiteSpace(height: 10),
                SubmitButton('Login', signIn),
                const WhiteSpace(),
                _rememberMeBox(),
                TapLabel(
                  "Don't have an account? Create one",
                  _goToRegister,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
