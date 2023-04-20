import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/search_bar.dart';
import 'package:gameshare/view/screens/search.dart';
import 'package:gameshare/view/components/infinite_scrollable_game_list.dart';
import 'package:gameshare/model/game.dart';
import 'package:gameshare/view/components/game_card.dart';



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

      final searchButton = find.widgetWithIcon(TextButton, Icons.search);
      expect(searchButton, findsOneWidget);
      
      //Act
      await tester.enterText(searchBarTextField, 'test');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(GameCard), findsWidgets);
    }); //End test
  });
}