import 'package:flutter/material.dart';
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
  }); //End group

  group('Games given by the API with different search queries', () {
    testWidgets('InfiniteScrollableGameList is generated correctly when the search query is updated', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(MaterialApp(
        home: SearchPage(),
      ));

      final searchBarTextField = find.byType(TextField);
      expect(searchBarTextField, findsOneWidget);
      
      //Act
      await tester.enterText(searchBarTextField, 'test');
      await tester.tap(finder)
    }); //End test
  });
}