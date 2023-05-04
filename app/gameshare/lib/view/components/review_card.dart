import 'package:gameshare/view/components/utils/add_horizontal_space.dart';

import 'package:gameshare/services/api_requests.dart';
import 'package:gameshare/view/screens/game.dart';
import 'package:gameshare/view/screens/user.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/review.dart';
import '../../services/auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/services/database_actions.dart';


class ReviewCard extends StatelessWidget {
  const ReviewCard( {
    Key? key,
    required this.review,
    this.isUser,
  }) : super(key: key);

  final bool? isUser;
  final Review review;

  getHeader() {
    if (isUser ?? false) {
      return GameName(review: review);
    } else {
      return ReviewUser(
        name: review.userEmail,
        gameId: review.gameId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5, 
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: const Offset(3, 3),
            blurRadius: 4,
            spreadRadius: 3,
          )
        ],
        color: Theme.of(context).colorScheme.background,
      ),
        child: Column(
          children: [
            getHeader(),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            ReviewRating(
              rating: review.rating,
            ),
            const SizedBox(height: 10),
            ReviewText(
              review: review.reviewText,
            ),
            const SizedBox(height: 10),
          ],
        ),
    );
  }
}

class GameName extends StatelessWidget {
  const GameName({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          getGame(review.gameId).then((value) => {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ____) => GamePage(game: value),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                )
              });
        },
        child: Text(
          review.gameName,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),

        ),

      ),
    );
  }
}

class ReviewUser extends StatelessWidget {
  ReviewUser({
    Key? key,
    required this.name,
    required this.gameId,
  }) : super(key: key);

  final String name;
  final int gameId;
  var currUser = FirebaseAuth.instance.currentUser;
  final Image image = const Image(
    image: AssetImage('assets/images/default_avatar.png'),
    width: 70,
    height: 70,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(child: image),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              bool cond = false;
              if (Auth().user != null) {
                cond = (Auth().user!.email) == name;
              }
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ____) =>
                      UserPage(user: name, isUser: cond),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            },
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold, fontSize: 15),
            )),
        ),
        if (currUser != null && currUser!.email == name)
          Expanded(
              flex: 0,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () { 
                        deleteReview(
                          FirebaseAuth.instance.currentUser!.email!,
                          gameId,
                          FirebaseFirestore.instance
                        );
                        
                      },
                      icon: const Icon(Icons.delete, size: 30)))),
        const addHorizontalSpace(size: 10)
      ],
    );
  }
}

class ReviewRating extends StatelessWidget {
  const ReviewRating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < rating; i++)
            Icon(
              Icons.videogame_asset,
              color: Colors.green,
              size: MediaQuery.of(context).size.width / 7,
            ),
          for (int i = 0; i < 5 - rating; i++)
            Icon(
              Icons.videogame_asset_outlined,
              color: Colors.green,
              size: MediaQuery.of(context).size.width / 7,
            ),
        ],
      ),
    );
  }
}

class ReviewText extends StatefulWidget {
  const ReviewText({
    Key? key,
    required this.review,
  }) : super(key: key);

  final String review;

  @override
  State<ReviewText> createState() => _ReviewTextState();
}

class _ReviewTextState extends State<ReviewText> {
  late bool showMore = false;
  late String buttonText = 'Show more';
  String mainText = '';
  late bool longText = true;

  List<Widget> getText() {
    if (widget.review.length <= 200) {
      longText = false;
      mainText = widget.review;
    } else if (!showMore) {
      longText = true;
      mainText = '${widget.review.substring(0, 200)}...';
      buttonText = 'Show more';
    } else {
      longText = true;
      mainText = widget.review;
      buttonText = 'Show less';
    }

    return [
      Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Text(
          mainText,
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
          )
        ),
      ),
      if (longText)
        ElevatedButton(
          onPressed: () {
            setState(() {
              showMore = !showMore;
            });
          },
          style: ButtonStyle(
            alignment: Alignment.center,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5)),
          ),
          child: Text(buttonText, textAlign: TextAlign.center),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getText(),
    );
  }
}
