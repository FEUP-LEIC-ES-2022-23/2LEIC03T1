import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGameService extends Mock implements GameService {}

void main() {
  group('testing if ', () {
    FlutterDriver driver;
    MockGameService gameService;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      gameService = MockGameService();
      when(gameService.searchGames('Super Mario')).thenAnswer((_) async => [
        Game(id: 1, name: 'Super Mario Bros.'),
        Game(id: 2, name: 'Super Mario Galaxy'),
        Game(id: 3, name: 'Super Mario Odyssey'),
      ]);
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Search for a game', () async {
      await driver.tap(find.byType(TextField));
      await driver.enterText('Super Mario');
      await driver.tap(find.byIcon(Icons.search));
      await driver.waitFor(find.text('Super Mario Bros.'));
      await driver.waitFor(find.text('Super Mario Galaxy'));
      await driver.waitFor(find.text('Super Mario Odyssey'));
    });

    test('Search for a game with no results', () async {
      await driver.tap(find.byType(TextField));
      await driver.enterText('asdfghjkl');
      await driver.tap(find.byIcon(Icons.search));
      await driver.waitFor(find.text('No results found.'));
    });

    test('Cancel search', () async {
      await driver.tap(find.byType(TextField));
      await driver.enterText('Search query');
      await driver.tap(find.byIcon(Icons.clear));
      expect(await driver.getText(find.byType(TextField)), '');
    });

    test('Infinite scrolling', () async {
      final scrollableList = find.byType(InfiniteScrollableGameList);
      final initialItemCount = await driver.getListItemCount(scrollableList);

      await driver.scroll(scrollableList, 0, -500, const Duration(milliseconds: 500));
      await driver.waitFor(find.byType(CircularProgressIndicator));

      final finalItemCount = await driver.getListItemCount(scrollableList);
      expect(finalItemCount, greaterThan(initialItemCount));
    });

    test('Navigation', () async {
      await driver.tap(find.byIcon(Icons.menu));
      await driver.waitFor(find.text('Settings'));
      await driver.tap(find.text('Settings'));
      await driver.waitFor(find.text('Dark mode'));
    });
  });
}