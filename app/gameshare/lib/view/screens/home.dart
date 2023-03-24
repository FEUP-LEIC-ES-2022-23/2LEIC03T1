import 'package:flutter/material.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';

import '../../platform_icons_icons.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 350,
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
            const ScrollableGameList(),
            const Icon( size: 0, PlatformIcons.android),
          ],
        ),
      )
    );
  }
}
