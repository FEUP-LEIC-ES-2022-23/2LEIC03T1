import 'package:flutter/material.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';

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
      appBar: AppBar(
        title:  Text(_searchQuery),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchBar(
            onSearch: _onSearch,

          ),
          Expanded(
            child: SizedBox( child:ScrollableGameList(scrollHorizontally: false,searchQuery: _searchQuery,),width: 350, ),
          ),
        ],
      ),
    );
  }
}