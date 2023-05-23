import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:gameshare/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle _font = GoogleFonts.montserratAlternates();

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    this.size = 30,
    this.weight = FontWeight.w900,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _font.copyWith(fontSize: size, fontWeight: weight, color: color),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _rememberMe,
      onChanged: (value) async {
        setState(() => _rememberMe = value ?? false);
        final prefs = await SharedPreferences.getInstance();
        if (value == true) {
          await prefs.setBool('rememberMe', true);
          await prefs.setBool('isDarkMode', themeProv.isDarkMode());
        }
        else {
          await prefs.setBool('rememberMe', false);
          await prefs.remove('isDarkMode');
        }
      },
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class MyLabel extends StatelessWidget {
  const MyLabel(
    this.text, {
    this.size = 16,
    this.weight = FontWeight.w800,
    this.color = MyAppColors.purple,
    this.left = true,
    Key? key,
  }) : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      child: MyText(text,
          size: size, weight: weight, color: Theme.of(context).accentColor),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton(
    this.text,
    this.onTap, {
    this.color_1 = const Color.fromARGB(255, 6, 30, 97),
    this.color_2 = const Color.fromARGB(255, 4, 3, 59),
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final Color color_1, color_2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          gradient: RadialGradient(
            radius: 5,
            colors: <Color>[color_1, color_2],
          ),
        ),
        child: MyText(text,
            size: 20, weight: FontWeight.w800, color: Colors.white),
      ),
    );
  }
}

class TapLabel extends StatelessWidget {
  const TapLabel(
    this.text,
    this.onTap, {
    this.size = 16,
    this.weight = FontWeight.w800,
    this.color = MyAppColors.purple,
    this.left = true,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final double size;
  final FontWeight weight;
  final Color color;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MyLabel(
        text,
        size: size,
        weight: weight,
        color: color,
        left: left,
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({
    this.height = 15,
    Key? key,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class DisplayError extends StatelessWidget {
  const DisplayError(
    this.error, {
    Key? key,
  }) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return MyText(error ?? "", size: 13, color: Colors.red);
  }
}
