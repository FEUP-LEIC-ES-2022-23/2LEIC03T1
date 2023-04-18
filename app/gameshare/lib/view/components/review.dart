import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Review extends StatelessWidget {
const Review({
  Key? key,
  required this.name,
  required this.review,
  required this.rating,
  }) : super(key: key);

  final String name;
  final String review;
  final int rating;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,

      height: 300,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        boxShadow:  <BoxShadow> [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: const Offset(3, 3),
            blurRadius: 4,
            spreadRadius: 3,
          )
        ],
        color: Theme.of(context).backgroundColor,
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
          ReviewText(
            review: review,
          ),
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
        Container(
          margin: const EdgeInsets.all(5),
          child: image
          ),
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
          )  
        ),
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



    );
  }
}

class ReviewText extends StatelessWidget {
  const ReviewText({
    Key? key,
    required this.review,
    }) : super(key: key);

  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        review,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 15,
          ),
        ),
    );
  }
}