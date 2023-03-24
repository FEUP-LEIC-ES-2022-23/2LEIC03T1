import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/game.dart';
import '../../services/api_requests.dart';
import '../../constants.dart' as constants;

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

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
          boxShadow: const <BoxShadow> [
            BoxShadow(
              color: Color(0x6fa4a4a2),
              offset: Offset(3, 3),
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          GameCardImage(game: game),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 5),
              for (int i = 0; i < 3 && i < game.platforms.length; i++)
                SizedBox(
                    height: 35,
                    width: 35,
                    child: Icon(constants.platformToIcon[game.platforms[i]])
                ),
              GameCardRating(game: game),
            ],
          ),
          const SizedBox(height: 5),
          GameCardName(game: game),
        ],
      ),
    );
  }
}

class GameCardName extends StatelessWidget {
  const GameCardName({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          game.name,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle (
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class GameCardRating extends StatelessWidget {
  const GameCardRating({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Expanded (
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Stack (
              alignment: Alignment.centerRight,
              children: [
                Container(
                  color: Colors.green,
                  height: 35,
                  width: 35,
                ),
                Positioned(
                  right: 2,
                  child: Text(
                    game.rating.toStringAsFixed(2),
                    style: const TextStyle (
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }
}

class GameCardImage extends StatelessWidget {
  const GameCardImage({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: FittedBox(
        fit: BoxFit.fill,
        child: CachedNetworkImage(
          imageUrl: game.image,
        ),
      ),
    );
  }
}