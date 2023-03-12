import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class App_Bar extends StatefulWidget {
  const App_Bar({super.key});

  @override
  State<App_Bar> createState() => _App_Bar();
}

class _App_Bar extends State<App_Bar> {
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
           alignment: Alignment.topRight,
           child: Container(
             child: TextButton(
               child: Icon(DarkThemePreferences().getTheme()? Icons.dark_mode_outlined:Icons.light_mode_outlined,color: Colors.white,),
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