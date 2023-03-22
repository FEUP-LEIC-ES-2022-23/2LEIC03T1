import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/darkThemeProvider.dart';
import '../../services/darkThemePrefs.dart';

class lightDarkModeButton extends StatefulWidget {
  const lightDarkModeButton({super.key});

  @override
  State<lightDarkModeButton> createState() => _lightDarkModeButton();
}

class _lightDarkModeButton extends State<lightDarkModeButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeState = Provider.of<DarkThemeProvider>(context);
    return SafeArea(

        child:SafeArea(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: TextButton(
                child: Icon(DarkThemePreferences().getTheme()? Icons.dark_mode_outlined:Icons.light_mode_outlined),
                onPressed: () {
                  setState(() {
                    themeState.darkTheme=!DarkThemePreferences().getTheme();
                  });

                },


              ),
            ),
          ),
        )
    );

  }
}

