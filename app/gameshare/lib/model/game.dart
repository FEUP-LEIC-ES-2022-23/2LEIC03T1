import 'package:flutter/cupertino.dart';
import 'package:gameshare/constants.dart';

class Game {
  final int gameId;
  double rating = 0;
  final List<String> platforms;
  final String image;
  final String name;
  late String description;

  Game ({
    required this.gameId,
    required this.image,
    required this.platforms,
    required this.name,
  });

  factory Game.fromJson(List<dynamic> json, int idx) {
    Map<String, dynamic> result = json[idx];

    return Game (
      gameId: result['id'],
      // Hard-coded placeholder image in case the game has no background image
      // TODO: Change the placeholder image to a more suitable one
      image: result['background_image'] ?? 'https://fastly.picsum.photos/id/237/3500/2095.jpg?hmac=y2n_cflHFKpQwLOL1SSCtVDqL8NmOnBzEW7LYKZ-z_o',
      platforms: [for (var el in result['platforms']) el['platform']['slug']],
      name: result['name'],
    );
  }

  List<IconData?> get uniquePlatformsIcons => {
    for (var platform in platforms) platformToIcon[platform]
  }.toList();
}



