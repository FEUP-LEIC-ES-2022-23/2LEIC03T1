import 'package:flutter/material.dart';
import 'package:gameshare/view/components/bars/top_bar.dart';
import 'package:gameshare/view/components/search_page/infinite_scrollable_game_list.dart';
import 'package:gameshare/view/components/search_page/search_bar.dart';

import '../components/bars/nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String _searchQuery = '';

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Search'),
      appBar: const TopBar(),
      body: Column(
        children: [
          SearchBar(
            onSearch: _onSearch,
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: InfiniteScrollableGameList(
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
