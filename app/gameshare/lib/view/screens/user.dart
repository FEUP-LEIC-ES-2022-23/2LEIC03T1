import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/view/components/input.dart';
import 'package:gameshare/view/components/review_card.dart';

import 'package:gameshare/view/components/utils/add_vertical_space.dart';
import 'package:gameshare/view/components/utils/rectangle_with_text.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/review.dart';
import '../../model/user.dart';
import '../../services/auth.dart';
import '../../services/database_actions.dart';
import '../components/bars/nav_bar.dart';
import '../components/bars/top_bar.dart';
import '../components/circular_progress.dart';
import '../components/text_utils/section_title.dart';
import '../components/text_utils/text_section.dart';
import 'edit_user.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {super.key, required this.user, required this.isUser, this.firestore});
  final String user;
  final bool isUser;
  final FirebaseFirestore? firestore;
  bool get _isUser => isUser;
  FirebaseFirestore get fireBaseStore =>
      firestore ?? FirebaseFirestore.instance;

  @override
  State<StatefulWidget> createState() => _UserPage(user: user);
}

class _UserPage extends State<UserPage> {
  _UserPage({
    required this.user,
  });
  final String user;
  late String name = "";
  late String about = "";
  late String img = "";
  late Timestamp timestamp;
  late bool isLoading = true;
  late bool madeRequest = false;
  late List<Review> reviews = [];
  bool get isUser => widget._isUser;
  @override
  void initState() {
    super.initState();
  }

  void setUserInfo(Users users) {
    setState(() {
      name = users.name;
      about = users.about;
      timestamp = users.timestamp;
      img = users.img;
    });
  }

  void setReviews(List<Review> _reviews) {
    setState(() {
      reviews = _reviews;
      isLoading = false;
    });
  }

  getBody() {
    if (name == "" || isLoading) {
      return const CircularProgressBar();
    } else {
      return ListView(children: [
        ...body(isUser, user, name, about, reviews, timestamp, img)
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!madeRequest)
      getUserInfo(user, widget.fireBaseStore)
          .then((value) => setUserInfo(value));
    if (!madeRequest)
      getUserGameReviews(user, widget.fireBaseStore)
          .then((value) => setReviews(value));
    setState(() {
      madeRequest = true;
    });
    return Scaffold(
      key: Key(user),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
        child: getBody(),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

body(bool isUser, String email, String name, String about, List<Review> reviews,
    Timestamp timestamp, String img) {
  double marginTop = 0;
  if (isUser)
    marginTop = 0;
  else
    marginTop = 15;
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
      margin: EdgeInsets.only(left: 15, top: marginTop),
      child: Row(
        children: [
          UserImage(size: 90, image: img),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [UserName(name: name), JoinedAt(timestamp: timestamp)],
          ),
        ],
      ),
    ),
    UserEmail(email: email),
    TextSection(title: "About", text: about),
    if (about == "")
      const RectangleWithText(text: "User don't have an about section yet"),
    MyReviews(reviews: reviews),
  ];
}

class MyReviews extends StatelessWidget {
  const MyReviews({super.key, required this.reviews});
  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SectionTitle(title: "My Reviews"),
          ),
          const addVerticalSpace(size: 25),
          if (reviews.isEmpty)
            const RectangleWithText(text: "No reviews have been written yet"),
          for (Review rev in reviews)
            ReviewCard(
              review: rev,
              isUser: true,
            ),
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
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
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
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      child: Image(
        image: AssetImage(
            image == "" ? 'assets/images/userPlaceholder.png' : image),
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
    return Text(
      name,
      overflow: TextOverflow.visible,
      softWrap: false,
      style: GoogleFonts.montserratAlternates(
          fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}

class JoinedAt extends StatelessWidget {
  const JoinedAt({super.key, required this.timestamp});
  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    String _date = date.toString().substring(0, 10);
    _date = _date.split('-').reversed.join('-');
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "Joined at: $_date",
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
            Auth().signOut();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ____) => LoginPage(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          },
          child: const Icon(
            Icons.logout,
            size: 35,
          )),
    );
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextButton(
        onPressed: () {
          goTo(context, const EditProfilePage());
        },
        child: const Icon(
          Icons.edit_note,
          size: 35,
        ),
      ),
    );
  }
}
