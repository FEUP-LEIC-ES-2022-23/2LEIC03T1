import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/view/screens/forgot_password.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/screens/user.dart';
import '../components/bars/nav_bar.dart';
import '../components/bars/top_bar.dart';

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
  late List<Widget> _widgets;
  late UserDataForm _userDataForm;

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

  @override
  void initState() {
    super.initState();
    _widgets = <Widget>[
      EntryFieldList(<Entry>[user, password]),
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
    _userDataForm = UserDataForm(_widgets);
  }

  void updateError(String res) {
    _error = res;

    for (int i = 0; i < _widgets.length; i++) {
      if (_widgets[i] is DisplayError) {
        _widgets[i] = DisplayError(_error);
        _userDataForm = UserDataForm(_widgets);
        break;
      }
    }
  }

  Future<void> signIn() async {
    String res = await _auth.signInEmailPassword(
      user.controller.text,
      password.controller.text,
    );
    if (res == _auth.success) {
      goTo(context, UserPage(user:user.controller.text, isUser: true,));
    } else {
      setState(() => updateError(res));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Login'),
      appBar: const TopBar(),
      body: _userDataForm,
      bottomNavigationBar: const NavBar(),
    );
  }
}