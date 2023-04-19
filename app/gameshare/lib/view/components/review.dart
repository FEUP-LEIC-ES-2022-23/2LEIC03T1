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
      width: MediaQuery.of(context).size.width,
      
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

          SizedBox(height: 10),

          ReviewText(
            review: review,
          ),

          SizedBox(height: 10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            for(int i = 0; i < rating; i++)
              Icon(
                Icons.videogame_asset,
                color:Colors.green,
                size: MediaQuery.of(context).size.width/7,
              ),
            for(int i = 0; i < 5-rating; i++)
              Icon(
                Icons.videogame_asset,
                color:Colors.grey,
                size: MediaQuery.of(context).size.width/7,
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
  
  List<Widget> getText(){

    if (widget.review.length <= 200) {
      longText = false;
      mainText = widget.review;
    }
    else if(!showMore){
      longText = true;
      mainText = widget.review.substring(0, 200) + '...';
      buttonText = 'Show more';
    }
    else{
      longText = true;
      mainText  = widget.review;
      buttonText = 'Show less';
    }

    return [
      Container(
        margin: const EdgeInsets.all(15),
        child: Text(
          mainText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: TextDecoration.none,
          )
          
          ),
        
      ),
      if (longText)
        ElevatedButton(
          onPressed: (){
            setState(() {
              showMore=!showMore;
            });
          },
          style: ButtonStyle(
            alignment: Alignment.center,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                )
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 40,right: 40,top:5,bottom: 5)),
          ),
          child: Text(buttonText,textAlign: TextAlign.center),

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
