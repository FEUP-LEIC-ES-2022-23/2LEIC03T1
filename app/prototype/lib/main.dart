import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:prototype/services/dark_theme_prefs.dart';

import 'consts/ theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  callBack() {
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DarkThemePreferences().setCallback(callBack);
    return  MaterialApp(
               debugShowCheckedModeBanner: false,
               title: 'GameShare',
               theme: Styles.themeData(
                   DarkThemePreferences().getTheme(), context),
               home: const WidgetTree(),
             );
           }

}
