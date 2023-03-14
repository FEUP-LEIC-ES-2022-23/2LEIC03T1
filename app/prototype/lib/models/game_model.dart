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
      // Hard-coded placeholder image in case the game has no background image
      image: result['background_image'] ?? 'https://fastly.picsum.photos/id/237/3500/2095.jpg?hmac=y2n_cflHFKpQwLOL1SSCtVDqL8NmOnBzEW7LYKZ-z_o',
      platforms: [for (var el in result['platforms']) el['platform']['slug']],
      name: result['name'],
    );
  }
}



