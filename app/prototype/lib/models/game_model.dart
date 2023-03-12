class Game {
  final int gameId;
  final int rating;
  final List<String> platforms;
  final String image;
  late String description;

  Game ({
    required this.gameId,
    required this.rating,
    required this.platforms,
    required this.image,
  });

  factory Game.fromJson(Map<String, dynamic> json, int idx) {
    Map<String, dynamic> result = json['results'][idx];

    return Game (
      gameId: result['id'],
      rating: result['rating'],
      image: result['background_image'],
      platforms: [for (var el in result['platforms']) el['platform']['slug']],
    );
  }
}



