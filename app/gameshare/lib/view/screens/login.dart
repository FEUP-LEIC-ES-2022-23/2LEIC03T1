import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/screens/forgot_password.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
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

  Future<void> _signIn() async {
    bool result = await _auth.signInEmailPassword(
      user.controller.text,
      password.controller.text,
    );
    if (!result) {
      setState(() => _error = 'Invalid email or password');
    } else {
      setState(() => _error = null);
    }
  }

  Future<void> signIn() async {
    await _signIn();
    if (_auth.user != null) _goToHome();
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

  void _goToHome() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ____) => HomePage(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ____) => ForgotPasswordPage(),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
      },
      child: const MyLabel('Forgot Password?', left: false, size: 15),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: _goToRegister,
      child: const MyLabel("Don't have an account? Create one", size: 15),
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

  Widget _loginButton() {
    return InkWell(
      onTap: () => signIn(),
      child: SubmitButton('Login', context),
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
