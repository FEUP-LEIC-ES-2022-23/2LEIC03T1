import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/game.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Game>> fetchGames({int? page, int? pageSize, String? searchQuery, List<String>? genres}) async {
  String url = buildUrl(page, pageSize, searchQuery, genres);

  final res = await http.get(Uri.parse(url));

  if (res.statusCode == 200) {
    var results = jsonDecode(res.body)['results'];
    return [for(int i = 0; i < results.length; i++) Game.fromJson(results, i)];
  }
  else {
    throw Exception('Failed to load games (Error ${res.statusCode})');
  }
}

String buildUrl(int? page, int? pageSize, String? searchQuery, List<String>? genres) {
  String url = '${dotenv.env['API_URL_BASE']}/games?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

  if (page != null) url += '&page=$page';

  if (pageSize != null) url += '&page_size=$pageSize';

  if (searchQuery != null) url += '&search=$searchQuery';

  if (genres != null && genres.isNotEmpty) url += '&genres=${genres.join(',')}';

  return url;
}
