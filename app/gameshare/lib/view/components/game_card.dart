import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:gameshare/view/screens/game.dart';

import '../../model/game.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final GestureTapDownCallback? onTapDown;

    return InkWell(
        key: Key(key.toString()),
        child: Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(3, 3),
                blurRadius: 4,
                spreadRadius: 3,
              )
            ],
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GameCardImage(game: game),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 5),
                  for (int i = 0;
                      i < 3 && i < game.uniquePlatformsIcons.length;
                      i++)
                    SizedBox(
                        height: 35,
                        width: 35,
                        child: Icon(game.uniquePlatformsIcons[i])),
                  const SizedBox(width: 5),
                  if (game.uniquePlatformsIcons.length > 3)
                    MorePlatformsNumber(game: game),
                  GameCardRating(
                    game: game,
                    size: 40,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GameCardName(game: game),
            ],
          ),
        ),
        onTapDown: (TapDownDetails tapDownDetails) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ____) => GamePage(game: game),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        });
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    width: 2.2,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
            Text('+${game.uniquePlatformsIcons.length - 3}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ))
          ],
        ));
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
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
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
    required this.size,
  });

  final Game game;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  decoration: const BoxDecoration(
                    color: MyAppColors.lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  height: size,
                  width: size,
                ),
                Text(
                  game.rating.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            )));
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
          errorWidget: (context, url, error) => Image.network(
              'https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg'),
        ),
      ),
    );
  }
}
