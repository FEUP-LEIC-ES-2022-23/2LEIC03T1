import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/model/game.dart';
import 'package:gameshare/services/api_requests.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'api_requests_test.mocks.dart';

@GenerateMocks([Client])
Future<void> main() async {

  await dotenv.load(fileName: ".env");
  String url = '${dotenv.env['API_URL_BASE']}/games?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

  group('Creating url to fetch games from RAWG api', () {

    test('Full valid url', () {
      int page = 1;
      int pageSize = 20;
      String searchQuery = 'mario';
      List<String> genres = ['puzzle', 'action'];

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page=1&page_size=20&search=mario&genres=puzzle,action';

      expect(actual, expected);
    });

    test('Url with null page', () {
      int? page;
      int pageSize = 20;
      String searchQuery = 'mario';
      List<String> genres = ['puzzle', 'action'];

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page_size=20&search=mario&genres=puzzle,action';

      expect(actual, expected);
    });

    test('Url with null page size', () {
      int page = 1;
      int? pageSize;
      String searchQuery = 'mario';
      List<String> genres = ['puzzle', 'action'];

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page=1&search=mario&genres=puzzle,action';

      expect(actual, expected);
    });

    test('Url with null search query', () {
      int page = 1;
      int pageSize = 20;
      String? searchQuery;
      List<String> genres = ['puzzle', 'action'];

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page=1&page_size=20&genres=puzzle,action';

      expect(actual, expected);
    });

    test('Url with null list of genres', () {
      int page = 1;
      int pageSize = 20;
      String searchQuery = 'mario';
      List<String>? genres;

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page=1&page_size=20&search=mario';

      expect(actual, expected);
    });

    test('Url with an empty list of genres', () {
      int page = 1;
      int pageSize = 20;
      String searchQuery = 'mario';
      List<String> genres = [];

      String actual = buildGameUrl(page, pageSize, searchQuery, genres);
      String expected = '$url&page=1&page_size=20&search=mario';

      expect(actual, expected);
    });
  });

  group('Fetch games', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test('Returns a game if the http call completes successfully', () async {
      when(client.get(Uri.parse('$url&page=1&page_size=1')))
          .thenAnswer((_) async => Response('{'
          '"results": [{'
          '"id": 1, '
          '"background_image": "TheImage", '
          '"platforms": [{"platform": {"name": "Playstation 4", "slug": "playstation4"}}], '
          '"name": "TheGame"'
          '}]}', 200));

      List<Game> result = await fetchGames(client, page: 1, pageSize: 1);

      expect(result.length, 1);
    });

    test('Returns an empty list http call returns a 404 error with detail "Invalid page."', () async {
      when(client.get(Uri.parse('$url&page=1&page_size=1')))
          .thenAnswer((_) async => Response('{"detail": "Invalid page."}', 404));

      List<Game> result = await fetchGames(client, page: 1, pageSize: 1);

      expect(result.isEmpty, true);
    });

    test('Throws an exception when the http call is not successful', () async {
      when(client.get(Uri.parse('$url&page=1&page_size=1')))
          .thenAnswer((_) async => Response('Unauthorized', 401));

      expect(fetchGames(client, page: 1, pageSize: 1), throwsException);
    });
  });
}