import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/game.dart';

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
      height: 300,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 5),
              for (int i = 0; i < 3 && i < game.uniquePlatformsIcons.length; i++)
                SizedBox(
                    height: 35,
                    width: 35,
                    child: Icon(game.uniquePlatformsIcons[i])
                ),
              const SizedBox(width: 5),
              if (game.uniquePlatformsIcons.length > 3)
                MorePlatformsNumber(game: game),
              GameCardRating(game: game),
            ],
          ),
          const SizedBox(height: 10),
          GameCardName(game: game),
        ],
      ),
    );
  }
}

class MorePlatformsNumber extends StatelessWidget {
  const MorePlatformsNumber({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        width: 35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    width: 2.2,
                  )
              ),
            ),
            Text(
                '+${game.uniquePlatformsIcons.length - 3}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )
            )
          ],
        )
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
                  decoration: const BoxDecoration(
                    color: Color(0xff13d772),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  height: 35,
                  width: 35,
                ),
                Positioned(
                  right: 2,
                  child: Text(
                    game.rating.toStringAsFixed(2),
                    style: const TextStyle (
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
