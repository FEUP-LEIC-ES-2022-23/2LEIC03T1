import 'package:flutter/material.dart';
import '../../model/game.dart';
import '../../services/api_requests.dart';
import 'game_card.dart';

class ScrollableGameList extends StatefulWidget {
  final int? page;
  final int? pageSize;
  final String? searchQuery;
  final List<String>? genres;

  const ScrollableGameList({
    Key? key,
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
    List<String> test = [];
    test.add('action');
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
            return SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var game in snapshot.data!)
                    GameCard(game: game),
                ],
              ),
            );
          }
        }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: SizedBox(
              height: 300,
              width: 275,
              child: Transform.scale(
                  scale: 0.2,
                  child: const CircularProgressIndicator(
                    strokeWidth: 20,
                    color: Color(0xff1F2D5A),
                  )
              )
          ),
        );
      },
    );
  }
}
