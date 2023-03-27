import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/view/screens/search_page.dart';
import 'view/components/search_bar.dart';
import 'view/components/scrollable_game_list.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teste pesquisa',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Page Test'),
        ),
        body: SearchPage(),
        ) ,
      );
  }

}
