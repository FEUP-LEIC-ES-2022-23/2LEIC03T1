import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/services/database_actions.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/screens/user.dart';
import 'package:gameshare/view/screens/login.dart';

import '../components/bars/nav_bar.dart';
import '../components/bars/top_bar.dart';

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
  late List<Widget> _widgets;
  late UserDataForm _userDataForm;

  final Entry _email = Entry(
        'email_field_register',
        'Email',
        TextEditingController(),
      ),
      _username = Entry(
        'username_field_register',
        'Username',
        TextEditingController(),
      ),
      _password = Entry(
        'password_field_register',
        'Password',
        TextEditingController(),
        hide: true,
      ),
      _confirmPassword = Entry(
        'confirm_password_field_register',
        'Confirm Password',
        TextEditingController(),
        hide: true,
      );

  @override
  void initState() {
    super.initState();
    _widgets = <Widget>[
      EntryFieldList(<Entry>[_email, _username, _password, _confirmPassword]),
      const WhiteSpace(),
      DisplayError(_error),
      const WhiteSpace(height: 10),
      SubmitButton('Register', signUp),
      const WhiteSpace(),
      TapLabel(
        'Already have an account',
        () => goTo(context, LoginPage()),
        left: true,
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

  bool checkMatchingPasswords() {
    if (_password.controller.text != _confirmPassword.controller.text) {
      setState(() => updateError('Passwords do not match'));
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    if (!checkMatchingPasswords()) return;
    String res = await _auth.signUpEmailPassword(
      _email.controller.text,
      _username.controller.text,
      _password.controller.text,
    );
    if (res == _auth.success) {
      goTo(context, UserPage(user: _auth.user!.email!, isUser: true));
    } else {
      setState(() => updateError(res));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Register'),
      appBar: const TopBar(),
      body: _userDataForm,
      bottomNavigationBar: const NavBar(),
    );
  }
}
