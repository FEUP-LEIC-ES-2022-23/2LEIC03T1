import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/widget_tree.dart';

import 'consts/ theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameShare',
      theme: Styles.themeData(DarkThemePreferences().getTheme(),context),
      home: const WidgetTree(),
    );
  }
}
