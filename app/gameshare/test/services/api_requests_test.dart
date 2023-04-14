import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/services/api_requests.dart';
import 'package:test/test.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  group('Creating url to fetch games from RAWG api', () {
    String url = '${dotenv.env['API_URL_BASE']}/games?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

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
}