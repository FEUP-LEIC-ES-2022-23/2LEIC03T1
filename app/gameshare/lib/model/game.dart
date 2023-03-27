import 'package:flutter/cupertino.dart';
import 'package:gameshare/consts/platform_to_icon.dart';

class Game {
  final int _gameId;
  double _rating = 0;
  final List<String> _platforms;
  final String _image;
  final String _name;
  late String _description;

  Game (
      this._gameId,
      this._image,
      this._platforms,
      this._name,
  );

  int get gameId => _gameId;
  List<String> get platforms => _platforms;
  String get image => _image;
  String get name => _name;
  double get rating => _rating;
  String get description => _description;

  factory Game.fromJson(List<dynamic> json, int idx) {
    Map<String, dynamic> result = json[idx];

    return Game (
      result['id'],
      // Hard-coded placeholder image in case the game has no background image
      // TODO: Change the placeholder image to a more suitable one
      result['background_image'] ?? 'https://fastly.picsum.photos/id/237/3500/2095.jpg?hmac=y2n_cflHFKpQwLOL1SSCtVDqL8NmOnBzEW7LYKZ-z_o',
      [for (var el in result['platforms']) el['platform']['slug']],
      result['name'],
    );
  }

  List<IconData?> get uniquePlatformsIcons => {
    for (var platform in _platforms) platformToIcon[platform]
  }.toList();
}



