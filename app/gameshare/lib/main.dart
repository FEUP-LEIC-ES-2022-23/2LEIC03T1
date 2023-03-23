import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/providers/themeProvider.dart';
import 'package:gameshare/services/themePrefs.dart';
import 'package:gameshare/view/components/lightDarkModeButton.dart';
import 'package:gameshare/view/screens/home.dart';
import 'package:provider/provider.dart';

import 'consts/themeData.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp( MyApp());
}
ThemeProvider themeProv= ThemeProvider();
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



 @override
  void dispose() {
    // TODO: implement dispose
    themeProv.removeListener(themeListener);
    super.dispose();
  }
  @override
  void initState() {
    themeProv.addListener(themeListener);
    super.initState();
  }
  themeListener(){
    if(mounted){
      setState(() {
      });
    }
  }


  @override
  Widget build(BuildContext context) {
              return MaterialApp(

                debugShowCheckedModeBanner: false,
                title: 'GameShare',
                theme:lightTheme,
                darkTheme: darkTheme,
                themeMode:  themeProv.themeMode,
                home: Scaffold(
                  appBar: AppBar(
                    title: const Text('GameShare'),
                    flexibleSpace: lightDarkModeButton()

                  ),
                  body: HomeScreen(),
                ),
              );
            }
}

