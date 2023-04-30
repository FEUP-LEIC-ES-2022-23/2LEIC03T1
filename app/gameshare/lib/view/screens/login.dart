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

  late final List<Entry> _entries;
  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    _entries = <Entry>[user, password];
    _widgets = <Widget>[
      EntryFieldList(_entries),
      TapLabel(
        'Forgot Password?',
        () => goTo(context, ForgotPasswordPage()),
        size: 15,
        left: false,
      ),
      const WhiteSpace(height: 20),
      DisplayError(_error),
      const WhiteSpace(height: 10),
      SubmitButton('Login', signIn),
      const WhiteSpace(),
      Row(children: const <Widget>[
        MyText(
          'Remember me',
          size: 15,
          weight: FontWeight.w800,
          //color: Theme.of(context).primaryColor,
        ),
        MyCheckBox(),
      ]),
      TapLabel(
        "Don't have an account? Create one",
        () => goTo(context, RegisterPage()),
        size: 15,
      ),
    ];
  }

  Future<void> signIn() async {
    String res = await _auth.signInEmailPassword(
      user.controller.text,
      password.controller.text,
    );
    if (res == _auth.success) {
      goTo(context, UserPage());
    } else {
      setState(() => _error = res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Login'),
      appBar: const TopBar(),
      body: UserDataForm(_widgets),
      bottomNavigationBar: const NavBar(),
    );
  }
}
