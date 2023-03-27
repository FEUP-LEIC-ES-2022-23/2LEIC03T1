import 'package:flutter/material.dart';
import '../../model/game.dart';
import '../../services/api_requests.dart';
import 'circular_progress.dart';
import 'game_card.dart';

class ScrollableGameList extends StatefulWidget {
  final bool scrollHorizontally;
  final int? page;
  final int? pageSize;
  final String? searchQuery;
  final List<String>? genres;

  const ScrollableGameList({
    Key? key,
    required this.scrollHorizontally,
    this.page,
    this.pageSize,
    this.searchQuery,
    this.genres,
  }) : super(key: key);

  @override
  State<ScrollableGameList> createState() => _ScrollableGameListState();
}

class _ScrollableGameListState extends State<ScrollableGameList> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames(
        page: widget.page,
        pageSize: widget.pageSize,
        searchQuery: widget.searchQuery,
        genres: widget.genres
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<Game>> (
      future: futureGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Text('No results found');
          }
          else {
            return ListView(
              scrollDirection: widget.scrollHorizontally ? Axis.horizontal : Axis.vertical,
              children: [
                for (var game in snapshot.data!)
                  GameCard(game: game),
              ],
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