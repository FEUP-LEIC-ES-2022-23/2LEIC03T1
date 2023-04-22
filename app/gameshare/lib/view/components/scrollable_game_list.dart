import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

import '../../model/game.dart';
import '../../services/api_requests.dart';
import 'game_card.dart';
import 'text_utils/api_error_message.dart';

class ScrollableGameList extends StatefulWidget {
  final bool scrollHorizontally;
  int? page;
  int? pageSize;
  String? searchQuery;
  List<String>? genres;

  ScrollableGameList({
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

  void fetch() {
    futureGames = fetchGames(IOClient(),
        page: widget.page,
        pageSize: widget.pageSize,
        searchQuery: widget.searchQuery,
        genres: widget.genres);
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    int index = 0;
    return FutureBuilder<List<Game>>(
      future: futureGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Text('No results found');
          } else {
            return ListView(
              scrollDirection:
                  widget.scrollHorizontally ? Axis.horizontal : Axis.vertical,
              children: [
                for (var game in snapshot.data!)
                  GameCard(
                    game: game,
                    key: Key(((widget.genres?.first ?? "None") +
                        ((index += 1)).toString())),
                  ),
              ],
            );
          }
        } else if (snapshot.hasError) {
          return APIErrorMessage(
            errMessage: snapshot.error.toString(),
          );
        }
        return Center(
          child: Transform.scale(
              scale: 2,
              child: const CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Color(0xff1F2D5A),
              )),
        );
      },
    );
  }
}
