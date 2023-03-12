import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:provider/provider.dart';


class light_night_mode_widget extends StatelessWidget {
  light_night_mode_widget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   return SafeArea(
       child:SafeArea(
         child: Align(
           alignment: Alignment.topRight,
           child: Container(
             child: TextButton(
               child: Icon(DarkThemePreferences().getTheme()? Icons.dark_mode_outlined:Icons.light_mode_outlined,color: Colors.white,),
               onPressed: () {

                   DarkThemePreferences().setDarkTheme(!DarkThemePreferences().getTheme());
                 })
             ),
           ),
         ),
       );

  }
}