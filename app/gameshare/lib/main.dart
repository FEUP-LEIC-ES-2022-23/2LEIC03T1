import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gameshare/services/providers/scroll_provider.dart';
import 'package:gameshare/services/providers/theme_provider.dart';
import 'package:gameshare/view/screens/home.dart';

import 'consts/theme_data.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkIfLoggedIn();
  runApp(const MyApp());
}

void checkIfLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final pref_rememberMe = prefs.getBool('rememberMe') ?? false;
  final pref_darkMode = prefs.getBool('isDarkMode') ?? false;

  if (pref_rememberMe == false) {
    Auth().signOut();
  }
  else if (Auth().user != null){
    if (pref_darkMode && !themeProv.isDarkMode()) {
      themeProv.toggleTheme();
    }
  }
}

ThemeProvider themeProv = ThemeProvider();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  ScrollController scrollController = ScrollProvider().controller;

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {});
    });
    themeProv.addListener(themeListener);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    themeProv.removeListener(themeListener); // dispose the controller
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
      home: const HomePage(),
    );
  }
}
