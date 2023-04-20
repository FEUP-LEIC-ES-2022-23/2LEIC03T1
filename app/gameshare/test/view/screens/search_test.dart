import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/screens/search.dart';
import 'package:gameshare/view/components/infinite_scrollable_game_list.dart';
import 'package:gameshare/model/game.dart';
import 'package:gameshare/view/components/game_card.dart';
import 'package:gameshare/model/game.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:gameshare/services/api_requests.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../services/api_requests_test.mocks.dart';


@GenerateMocks([Client])
void main() {
  group('Inputting text into the search bar', () {
    testWidgets('Search bar calls onSearch function when search button is pressed', (WidgetTester tester ) async {
      //Arrange
      String searchText = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBar(
              onSearch: (searchQuery) => searchText = searchQuery,
            ),
          ),
        ),
      );
      final searchBarTextField = find.byType(TextField);
      expect(searchBarTextField, findsOneWidget);

      final searchButton = find.byIcon(Icons.search);
      expect(searchBarTextField, findsOneWidget);

      //Act
      await tester.enterText(searchBarTextField, 'test');
      await tester.tap(searchButton);
      await tester.pump();

      //Assert
      expect(searchText, 'test');
    }); //End testWidget
  }); //End group

  group('Games given by the API with different search queries', () {
    testWidgets('InfiniteScrollableGameList is generated when the search button is pressed but has no games', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(MaterialApp(
        home: SearchPage(),
      ));

      final searchBarTextField = find.byType(TextField);
      expect(searchBarTextField, findsOneWidget);

      final searchButton = find.widgetWithIcon(TextButton, Icons.search);
      expect(searchButton, findsOneWidget);
      
      //Act
      await tester.enterText(searchBarTextField, 'test');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(InfiniteScrollableGameList), findsOneWidget);
    }); //End test

    late MockClient client;

    setUp(() {
      client = MockClient();
    });
    testWidgets('InfiniteScrollableGameList displays Game_cards correctly', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(MaterialApp(home: SearchPage()));

      final Game game1 = Game(1, 'Image 1', ['Nintendo Switch'], 'Super Mario 64');
      final Game game2 = Game(2, 'Image 2', ['Nintendo Switch', 'Nintendo Wii'], 'Super Mario Bros');
      final Game game3 = Game(3, 'Image 3', ['Nintendo Switch'], 'Super Mario Odyssey');

      List<Game> MockList = [];
      MockList.add(game1);
      MockList.add(game2);
      MockList.add(game3);

      when(fetchGames(client)).thenAnswer((_) async => MockList);

      final searchBarTextField = find.byType(TextField);
      expect(searchBarTextField, findsOneWidget);

      final searchButton = find.widgetWithIcon(TextButton, Icons.search);
      expect(searchButton, findsOneWidget);

      //Act
      await tester.enterText(searchBarTextField, 'Mario');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(GameCard), findsWidgets);
    });
  });
}