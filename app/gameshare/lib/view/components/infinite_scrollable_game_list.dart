import 'package:flutter/material.dart';
import '../../model/game.dart';
import '../../services/api_requests.dart';
import 'circular_progress.dart';
import 'game_card.dart';

class InfiniteScrollableGameList extends StatefulWidget {
  final bool scrollHorizontally;
  int? page;
  int? pageSize;
  String? searchQuery;
  List<String>? genres;

  InfiniteScrollableGameList({
    Key? key,
    required this.scrollHorizontally,
    this.page = 1,
    this.pageSize,
    this.searchQuery,
    this.genres,
  }) : super(key: key);

  @override
  State<InfiniteScrollableGameList> createState() => _InfiniteScrollableGameList();
}

class _InfiniteScrollableGameList extends State<InfiniteScrollableGameList> {
  List<Game> futureGames = [];
  late Future<List<Game>> test;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        widget.page = widget.page! + 1;

        setState(() {});
      }
    });
  }

  Future<List<Game>> fetch() async {
    futureGames.addAll(await fetchGames(
        page: widget.page,
        pageSize: widget.pageSize,
        searchQuery: widget.searchQuery,
        genres: widget.genres
    ));
    return futureGames;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // var searchState = context.watch<_SearchPageState>();
    if (widget.page == 1) futureGames.clear();
    test = fetch();
    return FutureBuilder <List<Game>> (
      future: test,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Text('No results found');
          }
          else {
            return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return GameCard(game: snapshot.data![index],);
                }
            );

          }
        }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressBar();
      },
    );
  }
}




