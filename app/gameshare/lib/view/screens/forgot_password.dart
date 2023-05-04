import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/helper_widgets.dart';

import '../components/bars/nav_bar.dart';
import '../components/bars/top_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Auth? auth, Key? key})
      : auth = auth ?? Auth(),
        super(key: key);

  final Auth? auth;
  Auth get authInstance => auth!;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? _error;
  Auth get _auth => widget.authInstance;
  late List<Widget> _widgets;
  late UserDataForm _userDataForm;

  final Entry email = Entry(
    'email_field_forgot_password',
    'Email',
    TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    _widgets = <Widget>[
      EntryFieldList(<Entry>[email]),
      const WhiteSpace(),
      DisplayError(_error),
      const WhiteSpace(height: 10),
      SubmitButton('Send', sendPasswordRecoveryEmail),
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

  Future<void> sendPasswordRecoveryEmail() async {
    String res = await _auth.sendPasswordRecoveryEmail(email.controller.text);
    if (res == _auth.success) {
      goTo(context, LoginPage());
    } else {
      setState(() => updateError(res));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('ForgotPassword'),
      appBar: const TopBar(),
      body: _userDataForm,
      bottomNavigationBar: const NavBar(),
    );
  }
}
