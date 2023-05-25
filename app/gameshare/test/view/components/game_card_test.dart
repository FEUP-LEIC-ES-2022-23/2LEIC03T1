import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/consts/platform_icons.dart';
import 'package:gameshare/model/game.dart';
import 'package:gameshare/view/components/game_card.dart';

void main() {
  late GameCard regularGameCard, moreThanThreePlatforms;

  setUp(() {
    regularGameCard = GameCard(
      game: Game(1, 'an-image', ['playstation4', 'pc'], 'Nice game'),
    );

    moreThanThreePlatforms = GameCard(
      game: Game(
          2, 'an-image', ['playstation4', 'pc', 'android', 'wii'], 'Nice game'),
    );
  });

  group('Test widgets on Game Card', () {
    testWidgets('Game Card should always have its game title, image and rating',
            (WidgetTester widgetTester) async {
          await widgetTester
              .pumpWidget(MaterialApp(home: Scaffold(body: regularGameCard)));

          expect(find.byType(GameCardImage), findsOneWidget);
          expect(find.byType(GameCardName), findsOneWidget);
          expect(find.byType(GameCardRating), findsOneWidget);
        });

    testWidgets(
        'Game Card should not display MorePlatformsWidget with 3 or different platforms',
            (WidgetTester widgetTester) async {
          await widgetTester
              .pumpWidget(MaterialApp(home: Scaffold(body: regularGameCard)));

          expect(find.byType(MorePlatformsNumber), findsNothing);
        });

    testWidgets(
        'Game Card should display MorePlatformsWidget with 3 or more different platforms',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(
              MaterialApp(home: Scaffold(body: moreThanThreePlatforms)));

          expect(find.byType(GameCardImage), findsOneWidget);
          expect(find.byType(GameCardName), findsOneWidget);
          expect(find.byType(GameCardRating), findsOneWidget);
          expect(find.byType(MorePlatformsNumber), findsOneWidget);
        });
  });

  group('Test if the widgets show the right information', () {
    // TODO: Test will need changes when the rating of each game is updated
    testWidgets(
        'Game card with 3 or less platforms should find game title, rating and each platform',
            (WidgetTester widgetTester) async {
          await widgetTester
              .pumpWidget(MaterialApp(home: Scaffold(body: regularGameCard)));

          expect(find.text('Nice game'), findsOneWidget);
          expect(find.text('0.00'), findsOneWidget);
          expect(find.byIcon(PlatformIcons.playstation), findsOneWidget);
          expect(find.byIcon(PlatformIcons.pc), findsOneWidget);
        });

    testWidgets(
        'Game card with more than 3 platforms should find game title, rating the first three platforms and a number with the additional number of platforms',
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(
              MaterialApp(home: Scaffold(body: moreThanThreePlatforms)));

          expect(find.widgetWithText(GameCardName, 'Nice game'), findsOneWidget);
          expect(find.widgetWithText(GameCardRating, '0.00'), findsOneWidget);
          expect(find.byIcon(PlatformIcons.playstation), findsOneWidget);
          expect(find.byIcon(PlatformIcons.pc), findsOneWidget);
          expect(find.byIcon(PlatformIcons.android), findsOneWidget);
          expect(find.byIcon(PlatformIcons.nintendo), findsNothing);
          expect(find.widgetWithText(MorePlatformsNumber, '+1'), findsOneWidget);
        });
  });
}