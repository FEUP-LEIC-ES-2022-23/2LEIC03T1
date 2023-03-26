import 'package:flutter/material.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Test',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 300, child: ScrollableGameList(scrollHorizontally: true)),
          ],
        ),
      )
    );
  }
}
