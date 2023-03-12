import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototype/provider/dark_theme_provider.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/widget_tree.dart';
import 'package:provider/provider.dart';

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
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    darkThemeProvider.darkTheme =
    await darkThemeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_){
            return darkThemeProvider;
          })
        ],
         child:Consumer<DarkThemeProvider>(
           builder: (context,darkThemeProvider,child) {
             return MaterialApp(
               debugShowCheckedModeBanner: false,
               title: 'GameShare',
               theme: Styles.themeData(
                   darkThemeProvider.darkTheme, context),
               home: const WidgetTree(),
             );
           }
         )

    );

  }
}
