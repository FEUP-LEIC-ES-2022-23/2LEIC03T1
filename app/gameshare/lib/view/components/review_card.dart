import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gameshare/services/database_actions.dart';

import '../../model/lOd.dart';
import '../../model/review.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard({
    Key? key,
    required this.review
  }) : super(key: key);

  Review review;

  @override
  Widget build(BuildContext context) {

    final String name = review.userEmail;
    final String text = review.reviewText;
    final int rating = review.rating;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
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
          ReviewUser(
            name: name,
          ),
          Divider(
            color: Theme.of(context).dividerColor,
            thickness: 1,
          ),
          ReviewRating(
            rating: rating,
          ),
          SizedBox(height: 10),
          ReviewText(
            review: text,
          ),
          SizedBox(height: 5),
          ReviewLikesDislikes( review: review,),
          SizedBox(height: 5),

        ],
      ),
    );
  }
}

class ReviewUser extends StatelessWidget {
  const ReviewUser({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;
  final Image image = const Image(
    image: AssetImage('assets/images/userPlaceholder.png'),
    width: 40,
    height: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(margin: const EdgeInsets.all(5), child: image),
        const SizedBox(width: 10),
        RichText(
            text: TextSpan(
          text: name,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // TODO: Navigate to user profile
              print('User profile');
            },
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        )),
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
    return Container(
      child: Padding(
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
      mainText = widget.review.substring(0, 200) + '...';
      buttonText = 'Show more';
    } else {
      longText = true;
      mainText = widget.review;
      buttonText = 'Show less';
    }

    return [
      Container(
        margin: const EdgeInsets.all(15),
        child: Text(mainText,
            style: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
            )),
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

class ReviewLikesDislikes extends StatefulWidget {
  ReviewLikesDislikes({
    Key? key,
    required this.review,
  }) : super(key: key);

  Review review;
  List<LoD> likesAndDislikes = List<LoD>.empty(growable: true);

  @override
  State<ReviewLikesDislikes> createState() => _ReviewLikesDislikesState();
}

class _ReviewLikesDislikesState extends State<ReviewLikesDislikes> {

  List<String?> likes = [];
  List<String?> dislikes = [];

  final auth = FirebaseAuth.instance.currentUser;


  toggleLike() {

    if (auth == null) {
      return;
    }

    final String? email = FirebaseAuth.instance.currentUser!.email ;

    if (likes.contains(email)) {
      likes.remove(email);
      widget.likesAndDislikes.remove(LoD(email!,1));
      widget.review.likesAndDislikes = widget.likesAndDislikes;
      removeLikeOrDislike(widget.review.gameId, widget.review.userEmail, 1);
    }
    else{
      if(dislikes.contains(email)){
        dislikes.remove(email);
        widget.likesAndDislikes.remove(LoD(email!,2));
        widget.review.likesAndDislikes = widget.likesAndDislikes;
        removeLikeOrDislike(widget.review.gameId, widget.review.userEmail, 2);
      }
      likes.add(email);
      widget.likesAndDislikes.add(LoD(email!,1));
      widget.review.likesAndDislikes = widget.likesAndDislikes;
      addLikeOrDislike(widget.review.gameId, widget.review.userEmail, 1);
    }
  }

  toggleDislike() {

    if (auth == null) {
      return;
    }

    final String? email = FirebaseAuth.instance.currentUser!.email ;

    if(dislikes.contains(email)){
      dislikes.remove(email);
      widget.likesAndDislikes.remove(LoD(email!,2));
      widget.review.likesAndDislikes = widget.likesAndDislikes;
      removeLikeOrDislike(widget.review.gameId, widget.review.userEmail, 2);
    }
    else{
      if(likes.contains(email)){
        likes.remove(email);
        widget.likesAndDislikes.remove(LoD(email!,1));
        widget.review.likesAndDislikes = widget.likesAndDislikes;
        removeLikeOrDislike(widget.review.gameId, widget.review.userEmail, 1);
      }
      dislikes.add(email);
      widget.likesAndDislikes.add(LoD(email!,2));
      widget.review.likesAndDislikes = widget.likesAndDislikes;
      addLikeOrDislike(widget.review.gameId, widget.review.userEmail, 2);
    }
  }


  @override
  Widget build(BuildContext context) {

    if (auth == null) {
      return SizedBox(width: 0, height: 0);
    }

    widget.likesAndDislikes = widget.review.likesAndDislikes;

    for(int i = 0; i < widget.likesAndDislikes.length; i++){
      if (widget.likesAndDislikes[i].likeOrDislike == 1){ // 1 is like
        likes.add(widget.likesAndDislikes[i].userEmail);
      }
      else if (widget.likesAndDislikes[i].likeOrDislike == 2){ // 2 is dislike
        dislikes.add(widget.likesAndDislikes[i].userEmail);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: (){toggleLike();},
            iconSize: 25,
            icon: Icon(
              Icons.thumb_up_alt_outlined,
              color: chooseColor(likes),
            )
        ),

        SizedBox(width: 2),

        Text(likes.length.toString()),

        SizedBox(width: 10),

        IconButton(
            onPressed: (){toggleDislike();},
            iconSize: 25,
            icon: Icon(
              Icons.thumb_down_alt_outlined,
              color: chooseColor(dislikes),
            )
        ),

        SizedBox(width: 2),

        Text(dislikes.length.toString()),

        SizedBox(width: 15),

      ],



    );
  }
}

Color chooseColor(List<String?> users){

  final auth = FirebaseAuth.instance.currentUser;
  if(auth == null){
    return Colors.black;
  }

  final String? email = auth.email;

  for (int i = 0; i < users.length; i++){
    if (users[i] == email){
      return Colors.green;
    }
  }
  return Colors.black;
}


