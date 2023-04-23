import 'package:flutter/material.dart';

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
    return Stack(
      children: [

        Image.network(
          imageUrl,
          color: Colors.black45,
          colorBlendMode: BlendMode.darken,
            errorBuilder: (context, url, error) => Image.network(
          'https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg'),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            height: 180,
            child: Center(
                child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            )))
      ],
    );
  }
}
