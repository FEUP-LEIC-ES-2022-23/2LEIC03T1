
import 'package:flutter/material.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';
import 'package:gameshare/view/components/top_bar.dart';

import '../components/nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String _searchQuery='';

  @override
  void initState(){
    super.initState();

  }
  void _onSearch(String query) {
    setState(() {
     _searchQuery=query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        children: [
          SearchBar(
            onSearch: _onSearch,

          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: ScrollableGameList(
                scrollHorizontally: false,
                searchQuery: _searchQuery,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

}

