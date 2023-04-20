import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/game.dart';

class ImageWithText extends StatelessWidget {
  const ImageWithText({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
      child: Stack(
        children: [
          Image.network(
          imageUrl,
          color: Colors.black45,
          colorBlendMode: BlendMode.darken,
        ),
          Container(
              margin: EdgeInsets.only(top:10),
              height: 180,
              child: Center(

                  child:Text(title,style: TextStyle(color: Colors.white,fontSize: 30),textAlign:TextAlign.center,)
              )
          )
        ],
      ),
    );
  }
}