import 'package:gameshare/model/game.dart';
import 'package:test/test.dart';

void main() {
  group('Creating a game instance', () {
    late List<dynamic> data;

    setUpAll(() async {
      data = [
        {
          'id': 1,
          'background_image': 'TheImage',
          'platforms': [
            {
              'platform': {'name': 'Playstation 4', 'slug': 'playstation4'}
            },
            {
              'platform': {'name': 'Wii U', 'slug': 'wii-u'}
            },
          ],
          'name': 'TheGame',
        },
        {
          'id': 2,
          'background_image': null,
          'platforms': [
            {
              'platform': {'name': 'Playstation 4', 'slug': 'playstation4'}
            },
            {
              'platform': {'name': 'Wii U', 'slug': 'wii-u'}
            },
          ],
          'name': 'TheGame',
        },
        {
          'id': 3,
          'background_image': 'TheImage',
          'platforms': null,
          'name': 'TheGame',
        },
      ];
    });

    test('With regular values', () {
      Game game = Game.fromJson(data, 0);

      expect(game.gameId == 1, true);
      expect(game.image == 'TheImage', true);
      expect(game.platforms.length == 2, true);
      expect(game.platforms[0] == 'playstation4', true);
      expect(game.platforms[1] == 'wii-u', true);
      expect(game.name == 'TheGame', true);
    });

    test('With no background image', () {
      Game game = Game.fromJson(data, 1);

      expect(game.gameId == 2, true);
      expect(
          game.image ==
              'https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg',
          true);
      expect(game.platforms.length == 2, true);
      expect(game.platforms[0] == 'playstation4', true);
      expect(game.platforms[1] == 'wii-u', true);
      expect(game.name == 'TheGame', true);
    });

    test('With no platforms', () {
      Game game = Game.fromJson(data, 2);

      expect(game.gameId == 3, true);
      expect(game.image == 'TheImage', true);
      expect(game.platforms.isEmpty, true);
      expect(game.name == 'TheGame', true);
    });
  });
}
