import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:gameshare/services/providers/ScrollProvider.dart';
import 'package:gameshare/view/components/NavBar.dart';
import 'package:gameshare/view/components/TopBar.dart';
import 'package:gameshare/view/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:gameshare/services/providers/themeProvider.dart';
import 'package:gameshare/services/themePrefs.dart';
import 'package:gameshare/view/components/lightDarkModeButton.dart';
import 'package:gameshare/view/screens/home.dart';


import 'consts/themeData.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp( MyApp());
}
ThemeProvider themeProv= ThemeProvider();
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();

}




class _MyApp extends State<MyApp>{
  ScrollController scrollController= ScrollProvider().controller;
  void initState() {
    scrollController.addListener(() {
        setState(() {
        });
      });
    themeProv.addListener(themeListener);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    themeProv.removeListener(themeListener);// dispose the controller
    super.dispose();
  }
  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }






  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: lightTheme,
     darkTheme: darkTheme,
     themeMode: themeProv.themeMode,
     home:HomeScreen(),
   );
  }
}

