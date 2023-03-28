import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:gameshare/services/providers/theme_provider.dart';

class LightDarkModeButton extends StatefulWidget {
  const LightDarkModeButton({super.key});

  @override
  State<LightDarkModeButton> createState() => _LightDarkModeButton();
}

class _LightDarkModeButton extends State<LightDarkModeButton> {
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
        child: TextButton(
            child: Icon(themeProv.isDarkMode()? Icons.dark_mode_outlined:Icons.light_mode_outlined, color: MyAppColors.lightGreen,),
            onPressed: () {
              setState(() {
                themeProv.toggleTheme();
              });

            },
        ),
      ),
    );

  }
}

