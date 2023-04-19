import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/screens/search.dart';
import 'package:gameshare/view/components/infinite_scrollable_game_list.dart';
import 'package:gameshare/model/game.dart';
//import 'package:gameshare/model/genre.dart';
//import 'package:gameshare/services/api_requests.dart';
//import 'package:http/http.dart';



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

    //To finish
    testWidgets('Search Page updates the searchQuery when the onSearch function is called', (WidgetTester tester) async {
      //Arrange
      final searchPage =  SearchPage();
      await tester.pumpWidget(searchPage);

      final searchBarTextField = find.byType(TextField);
      expect(searchBarTextField, findsOneWidget);

      final searchButton = find.widgetWithIcon(TextButton, Icons.search);
      expect(searchButton, findsOneWidget);

      final searchBar = find.byType(SearchBar);
      expect(searchBar, findsOneWidget);

      late String searchText = '';

      //Act
      await tester.enterText(searchBarTextField, 'test');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      final _SearchPageState searchPageState = tester.state(find.byType(SearchPage));
      //Assert
      expect(searchPageState. 'test');
    });

    //Alternative Test (To finish)
    test('Search page updates the searchQuery when the onSearch function is called', () {
      //Arrange
      const searchPage = SearchPage();
      final element = searchPage.createElement();
      final searchPageState = element.;
      searchPageState.
    });
  }); //End group

  group('Games requested by API with different search queries', () {
    test('Search query contains the full name of a game', () {

    });

    test('Search query contains part of the name of a game', () {

    });

    test('Search query contains the full name of a game', () {

    });
  });
}