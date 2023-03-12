import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:provider/provider.dart';


class App_Bar extends StatefulWidget {

  App_Bar();

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

   return SafeArea(
       child:SafeArea(
         child: Align(
           alignment: Alignment.topRight,
           child: Container(
             child: TextButton(
               child: Icon(DarkThemePreferences().getTheme()? Icons.dark_mode_outlined:Icons.light_mode_outlined,color: Colors.white,),
               onPressed: () {
                 setState(() {
                   DarkThemePreferences().setDarkTheme(!DarkThemePreferences().getTheme());
                 });

               },


             ),
           ),
         ),
       )
   );

  }
}