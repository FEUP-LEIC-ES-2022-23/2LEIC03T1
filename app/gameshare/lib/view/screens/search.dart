import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../components/nav_bar.dart';
import '../components/top_bar.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';
import 'package:gameshare/view/components/nav_bar.dart';
import 'package:gameshare/view/components/top_bar.dart';
import 'package:gameshare/view/components/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String _searchQuery = ' ';
  int _pageSize = 20;

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
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
            child: ScrollableGameList(
                scrollHorizontally: false,
                searchQuery: _searchQuery
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
