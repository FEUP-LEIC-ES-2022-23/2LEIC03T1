import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/services/api_requests.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  fetchGames(page: 2);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'haahah',
      home: Scaffold(
        appBar: AppBar(title: const Text('Lmao')),
        body: Center(
          child: SelectionArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Selectable text'),
                SelectionContainer.disabled(child: Text('Non-selectable text')),
                Text('Selectable text'),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
