import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/providers/darkThemeProvider.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:provider/provider.dart';

import 'consts/themeData.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
                theme: Styles.mainTheme(
                    darkThemeProvider.darkTheme, context),
                home: HomeScreen(),
              );
            }
        )

    );

  }
}
