import 'package:flutter/material.dart';
import 'package:gameshare/view/components/top_bar.dart';
import '../../services/providers/scroll_provider.dart';
import '../components/nav_bar.dart';

import 'package:gameshare/view/components/scrollable_game_list.dart';

import '../components/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ListView(
          controller: ScrollProvider.scrollController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget> [
                SectionTitle(title: 'Test'),
              ],
            ),
            const SizedBox(height: 300, child: ScrollableGameList(scrollHorizontally: true)),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );

  }
}

