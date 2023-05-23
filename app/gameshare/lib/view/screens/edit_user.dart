import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameshare/model/user.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/services/database_actions.dart';
import 'package:gameshare/view/components/bars/top_bar.dart';
import 'package:gameshare/view/components/helper_widgets.dart';
import 'package:gameshare/view/screens/user.dart';

import '../components/bars/nav_bar.dart';
import '../components/input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? email = Auth().email;
  String? message;
  late final Users user;

  final Entry _username = Entry(
    'username_field_edit',
    'Username',
    TextEditingController(),
  );

  final Entry about = Entry(
    'about_field_edit',
    'About',
    TextEditingController(),
  );

  void getUser() async {
    if (email == null) return;
    user = await getUserInfo(email ?? "", FirebaseFirestore.instance);
    _username.controller.text = user.name;
    about.controller.text = user.about;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void saveData() async {
    if (email == null) return;

    String res = await updateUser(
      email,
      name: _username.controller.text,
      about: about.controller.text,
    );

    setState(() => message = res);
  }

  Widget displayMessage() {
    if (message == null) return const SizedBox.shrink();
    Color color = message!.contains('success') ? Colors.green : Colors.red;
    return MyText(
      message as String,
      color: color,
      size: 16,
      weight: FontWeight.w500,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (email == null) {
      return const Text("You are not logged in");
    }
    return Scaffold(
      key: const Key('edit_profile_page'),
      appBar: const TopBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              const WhiteSpace(height: 10),
              const UserImage(size: 90, image: ""),
              const WhiteSpace(height: 20),
              EntryField(_username),
              EntryField(about, lines: 5),
              const WhiteSpace(height: 10),
              displayMessage(),
              const WhiteSpace(height: 10),
              SubmitButton('Save', saveData),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
