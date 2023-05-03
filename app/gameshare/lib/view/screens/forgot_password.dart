import 'package:flutter/material.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/view/screens/register.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import '../components/nav_bar.dart';
import '../components/top_bar.dart';

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

  final Entry email = Entry(
    'email_field_forgot_password',
    'Email',
    TextEditingController(),
  );

  final List<Entry> _entries = <Entry>[];

  @override
  void initState() {
    super.initState();
    _entries.add(email);
  }

  Future<void> sendPasswordRecoveryEmail() async {
    bool result = await _auth.sendPasswordRecoveryEmail(email.controller.text);
    if (!result) {
      setState(() => _error = 'Invalid email');
    } else {
      setState(() => _error = null);
    }
  }

  Widget _sendButton() {
    return InkWell(
      onTap: sendPasswordRecoveryEmail,
      child: SubmitButton('Send', context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('ForgotPassword'),
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
                _sendButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
