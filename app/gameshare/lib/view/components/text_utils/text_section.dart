import 'package:flutter/material.dart';
import 'package:gameshare/view/components/text_utils/section_title.dart';

import '../../../services/utils.dart';

class TextSection extends StatefulWidget {
  TextSection({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  State<TextSection> createState() => _TextSection(title: title, text: text);
}

class _TextSection extends State<TextSection> {
  _TextSection({
    required this.title,
    required this.text,
  });

  @override
  void initState() {
    super.initState();
  }

  final String title;
  final String text;
  late bool showMore = false;
  late bool showButton = true;

  List<Widget> getText() {
    String mainText;
    String buttonText;
    showButton = true;
    if (showMore) {
      mainText = text;
      buttonText = "Show less";
    } else {
      if (text.length > 300) {
        mainText = "${text.substring(0, 300)}...";
      } else {
        mainText = text;
        showButton = false;
      }
      buttonText = "Show More";
    }
    return [
      Container(
        alignment: Alignment.center,
        key: const Key("mainText"),
        child: Text(
            Html(mainText),
            style: const TextStyle(fontSize: 20)
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      if (showButton)
        ElevatedButton(
          key:const Key("showButton"),
          onPressed: () {
            setState(() {
              showMore = !showMore;
            });
          },
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            alignment: Alignment.center,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5)),
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SectionTitle(title: title),
          const SizedBox(
            height: 15,
          ),
          ...getText(),
        ],
      ),
    );
  }
}
