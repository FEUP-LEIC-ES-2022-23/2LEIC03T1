import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameshare/model/user.dart';
import 'package:gameshare/services/auth.dart';
import 'package:gameshare/services/database_actions.dart';
import 'package:gameshare/view/components/bars/top_bar.dart';

import '../components/bars/nav_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? email = Auth().email;
  late final Users user;

  void getUser() async {
    if (email == null) return;
    user = await getUserInfo(email ?? "", FirebaseFirestore.instance);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (email == null) {
      return const Text("You are not logged in");
    }
    return Scaffold(
      key: const Key('edit_profile_page'),
      appBar: const TopBar(),
      body: Container(),
      bottomNavigationBar: const NavBar(),
    );
  }
}
