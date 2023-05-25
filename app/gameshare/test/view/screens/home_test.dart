import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';
import 'package:gameshare/view/screens/home.dart';
import '../../mocks.dart';
import '../../services/api_requests_test.mocks.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockClient client = MockClient();
  await dotenv.load(fileName: ".env");
  String gamesUrl =
      '${dotenv.env['API_URL_BASE']}/games?key=${dotenv.env['FLUTTER_APP_API_KEY']}';
  String genresUrl =
      '${dotenv.env['API_URL_BASE']}/genres?key=${dotenv.env['FLUTTER_APP_API_KEY']}';

  testWidgets('There should be a row for each game genre in the home page', (widgetTester) async {
    when(client.get(Uri.parse(genresUrl))).thenAnswer((_) async => Response(
        '{"results": ['
            '{"name": "Action", "slug": "action"},'
            '{"name": "Puzzle", "slug": "puzzle"}'
            ']}',
        200));

    when(client.get(Uri.parse('$gamesUrl&page=1&page_size=1&genres=action')))
        .thenAnswer((_) async => Response(
        '{'
            '"results": [{'
            '"id": 1, '
            '"background_image": "TheImage", '
            '"platforms": [{"platform": {"name": "Playstation 4", "slug": "playstation4"}}], '
            '"name": "TheGame"'
            '},'
            '{'
            '"id": 2, '
            '"background_image: "AnotherImage",'
            '"platforms": [{"platform": {"name": "Playstation 4", "slug": "playstation4"}}], '
            '"name": "AnotherGame"'
            '}]}',
        200));

    when(client.get(Uri.parse('$gamesUrl&page=1&page_size=1&genres=puzzle')))
        .thenAnswer((_) async => Response(
        '{'
            '"results": [{'
            '"id": 3, '
            '"background_image": "PuzzleImage", '
            '"platforms": [{"platform": {"name": "Playstation 4", "slug": "playstation4"}}], '
            '"name": "PuzzleGame"'
            '}]}',
        200));
    Widget test = MaterialApp(home: HomePage(client: client,));
    await widgetTester.pumpWidget(test);
    await widgetTester.pumpFrames(test, const Duration(seconds: 10));

    expect(find.byType(ScrollableGameList), findsNWidgets(2));
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('Puzzle'), findsOneWidget);
  });
}