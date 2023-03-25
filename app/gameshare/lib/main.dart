import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/services/providers/ScrollProvider.dart';
import 'package:gameshare/view/components/NavBar.dart';
import 'package:gameshare/view/components/TopBar.dart';
import 'package:gameshare/view/screens/home.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home:HomePage(),

    );

  }

}
