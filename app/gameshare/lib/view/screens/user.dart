import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:gameshare/view/components/top_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/nav_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.user,
    required this.isUser,
  });
  final User user;
  final bool isUser;
  bool get _isUser => isUser;

  @override
  State<StatefulWidget> createState() => _UserPage(user: user);
}

class _UserPage extends State<UserPage> {
  _UserPage({
    required this.user,
  });
  final User user;
  bool get isUser => widget._isUser;

  String getJoinDate(){
    return "xx/xx/xxxx";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: ListView(
        children: [
          if (isUser)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                EditProfile(),
                Logout(),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                UserImage(size: 90, image: user.photoURL),
                Column(
                  children: [
                    UserName(name: user.displayName ?? "Dude get a name"),
                    Align(
                        child: Text(getJoinDate(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                        alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ],
            ),
          ),
          UserEmail(email: user.email),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

class UserEmail extends StatelessWidget {
  const UserEmail({super.key, required this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          email ?? "getaemial@idiot.com",
          style: const TextStyle(fontSize: 15),
        ));
  }
}

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.image, required this.size});
  final String? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 20),
      child: Image(
        image: AssetImage(image ?? 'assets/images/userPlaceholder.png'),
        width: size,
        height: size,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class UserName extends StatelessWidget {
  UserName({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: GoogleFonts.montserratAlternates(
          fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: const Icon(Icons.logout));
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Icon(Icons.edit_note),
    );
  }
}
