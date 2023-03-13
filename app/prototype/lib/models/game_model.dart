class Game {
  final int gameId;
  final double rating;
  final List<String> platforms;
  final String image;
  final String name;
  late String description;

  Game ({
    required this.gameId,
    required this.rating,
    required this.platforms,
    required this.name,
    required this.image,
  });

  factory Game.fromJson(List<dynamic> json, int idx) {
    Map<String, dynamic> result = json[idx];

    return Game (
      gameId: result['id'],
      rating: result['rating'],
      image: result['background_image'],
      platforms: [for (var el in result['platforms']) el['platform']['slug']],
      name: result['name'],
    );
  }
}



