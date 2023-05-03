import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/view/components/review_card.dart';
import 'package:gameshare/view/components/section_title.dart';
import 'package:gameshare/view/components/text_section.dart';
import 'package:gameshare/view/components/top_bar.dart';
import 'package:gameshare/view/components/utils/add_vertical_space.dart';
import 'package:gameshare/view/components/utils/rectangle_with_text.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/review.dart';
import '../../model/user.dart';
import '../../services/auth.dart';
import '../../services/database_actions.dart';
import '../components/circular_progress.dart';
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
  late String name="";
  late String about="";
  bool get isUser => widget._isUser;
  String getUserAbout() {
    String about = "My life is boring " * 20;
    return about;
  }
  Future<Users> getUsers(){
    return getUserInfo(user.email!);
  }
  @override
  void initState(){
    super.initState();
  }
  void setUserInfo(Users users){
    setState(() {
      name=users.name;
      about=users.about;
    });
  }
  getBody(){
    if(name=="") {
      return const CircularProgressBar();
    } else {
      return ListView( children:[ ...body(isUser, user, name, about)]);
    }
  }


  @override
  Widget build(BuildContext context) {
    getUserInfo(user.email!).then((value) => setUserInfo(value));
      return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
        child: getBody(),
      ),
      bottomNavigationBar: const NavBar(),
    );
    }

}

body(bool isUser,User user,String name,String about){
  return [
    if (isUser)
      Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: const [
          EditProfile(),
          Logout(),
        ],
      ),
    Container(
      margin: const EdgeInsets.only(left: 15,top: 0),
      child: Row(
        children: [
          UserImage(size: 90, image: user.photoURL),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserName(name: name),
              JoinedAt(user: user)
            ],
          ),
        ],
      ),
    ),
    UserEmail(email: user.email),
    TextSection(title: "About", text: about),
    if(about=="") const RectangleWithText(text: "User don't have an about section yet"),
    MyReviews(user: user),
  ];
}

class MyReviews extends StatelessWidget {
  const MyReviews({super.key, required this.user});
  final User user;
  List<ReviewCard> getUserReviews() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    late List<ReviewCard> reviews = getUserReviews();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      //padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Padding(child: const SectionTitle(title: "My Reviews"),padding: const EdgeInsets.only(left: 10,right: 10),),
          const addVerticalSpace(size: 25),
          if (reviews.isEmpty)
             RectangleWithText(text: "No reviews have been written yet"),
          ...reviews,
        ],
      ),
    );
  }
}

class UserEmail extends StatelessWidget {
  const UserEmail({super.key, required this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
        child: Text(
          "Email: ${email ?? "getaemial@dude.com"}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          overflow: TextOverflow.fade,
          softWrap: false,
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
      margin: const EdgeInsets.only(right: 20,),
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
  const UserName({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return  Text(
        name,
        style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}

class JoinedAt extends StatelessWidget {
  const JoinedAt({super.key, required this.user});
  final User user;
  String getJoinDate() {
    return "Joined at: xx/xx/xxxx";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
          getJoinDate(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      child: TextButton(
          onPressed: () {
            Auth auth = Auth();
            auth.signOut();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ____) => LoginPage(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          },
          child: const Icon(Icons.logout,size: 35,)),
    );
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 50,
      child: TextButton(
        onPressed: () {},
        child: const Icon(Icons.edit_note,size: 35,),
      ),
    );
  }
}
