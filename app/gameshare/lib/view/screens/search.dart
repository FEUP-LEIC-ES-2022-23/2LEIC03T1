import 'package:flutter/material.dart';

import '../components/nav_bar.dart';
import '../components/top_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      appBar: TopBar(),

      body: Text("lololo"),

      bottomNavigationBar: NavBar(),

    );
  }
}
