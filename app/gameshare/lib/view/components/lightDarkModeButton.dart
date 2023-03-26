import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/main.dart';
import 'package:gameshare/services/providers/themeProvider.dart';

import '../../services/themePrefs.dart';


class lightDarkModeButton extends StatefulWidget {


  @override
  State<lightDarkModeButton> createState() => _lightDarkModeButton();
}

class _lightDarkModeButton extends State<lightDarkModeButton> {
  ThemeProvider themeProv= ThemeProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SafeArea(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          child: TextButton(
            child: Icon(themeProv.isDarkMode()? Icons.dark_mode_outlined:Icons.light_mode_outlined),
            onPressed: () {
              setState(() {
                themeProv.toggleTheme();
              });

            },
          ),
        ),
      ),
    );

  }
}

