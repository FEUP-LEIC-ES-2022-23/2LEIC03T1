import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gameshare/model/api_exception.dart';
import 'package:http/http.dart' as http;
import '../model/game.dart';
import '../model/genre.dart';

Future<List<Genre>> fetchGenres(http.Client client) async {
  final String url =
      '${dotenv.env['API_URL_BASE']}/genres?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

  final res = await client.get(Uri.parse(url));

  if (res.statusCode == 200) {
    var results = jsonDecode(res.body)['results'];
    return [
      for (int i = 0; i < results.length; i++) Genre.fromJson(results, i)
    ];
  } else {
    throw ApiException('Failed to load genres', res.statusCode);
  }
}

Future<List<Game>> fetchGames(http.Client client,
    {int? page,
    int? pageSize,
    String? searchQuery,
    List<String>? genres}) async {
  String url = buildGameUrl(page, pageSize, searchQuery, genres);

  final res = await client.get(Uri.parse(url));
  var decodedJson = jsonDecode(res.body);

  if (res.statusCode == 200) {
    return [
      for (int i = 0; i < decodedJson.length; i++)
        Game.fromJson(decodedJson['results'], i)
    ];
  }
  // Already retrieved all games
  else if (res.statusCode == 404 && decodedJson['detail'] == 'Invalid page.') {
    return [];
  } else {
    throw ApiException('Failed to load games', res.statusCode);
  }
}

Future<String> getGameDescription(int? id) async {
  String url =
      '${dotenv.env['API_URL_BASE']}/games/$id?key=${dotenv.env['FLUTTER_APP_API_KEY']}';
  final res = await http.get(Uri.parse(url));
  var results = jsonDecode(res.body);
  return results['description'];
}

String buildGameUrl(
    int? page, int? pageSize, String? searchQuery, List<String>? genres) {
  String url =
      '${dotenv.env['API_URL_BASE']}/games?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

  if (page != null) url += '&page=$page';

  if (pageSize != null) url += '&page_size=$pageSize';

  if (searchQuery != null) url += '&search=$searchQuery';

  if (genres != null && genres.isNotEmpty) url += '&genres=${genres.join(',')}';

  return url;
}
