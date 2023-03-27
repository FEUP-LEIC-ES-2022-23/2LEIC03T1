import 'package:flutter/material.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';

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
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchBar(
            onSearch: _onSearch,
          ),
          Expanded(
            child: ScrollableGameList(
              scrollHorizontally: false,
              searchQuery: _searchQuery,
            ),
          ),
        ],
      ),
    );
  }
}