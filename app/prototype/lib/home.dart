import 'package:flutter/material.dart';
import 'package:prototype/components/light_night_mode_widget.dart';
import 'package:prototype/search.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/user.dart';
import 'consts/theme_data.dart';
import 'models/game_model.dart';
import 'services/api_requests.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Styles.themeData(DarkThemePreferences().getTheme(), context),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GameShare'),
          flexibleSpace: LightNightModeWidget(),
        ),
        body: Scaffold(
          body: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView (
                        children: [
                          GameSection(title: 'Page 1 of all games'),
                          GameSection(title: 'Page 2 of all games', page: 2),
                          GameSection(title: 'Page 1 of Mario games', searchQuery: 'Mario'),
                          GameSection(title: 'Page 1 of Puzzle and Platform games', genres: ['puzzle', 'platform']),
                        ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'User',
                ),
              ],
              currentIndex: _selected,
              selectedItemColor: const Color(0xff08C076),
              backgroundColor: const Color(0xff1B274B),
              onTap: (int index) {
                switch (index) {
                  case 0:
                    break;
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserScreen(),
                      ),
                    );
                    break;
                }
                setState(() {
                  _selected = index;
                });
              }),
        ),
      ),
    );
  }
}

class GameSection extends StatefulWidget {
  final String title;
  final int? page;
  final int? pageSize;
  final String? searchQuery;
  final List<String>? genres;

  const GameSection({
    Key? key,
    required this.title,
    this.page,
    this.pageSize,
    this.searchQuery,
    this.genres,
  }) : super(key: key);

  @override
  State<GameSection> createState() => _GameSectionState();
}

class _GameSectionState extends State<GameSection> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    List<String> test = [];
    test.add('action');
    futureGames = fetchGames(
        page: widget.page,
        pageSize: widget.pageSize,
        searchQuery: widget.searchQuery,
        genres: widget.genres
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: 350,
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: DarkThemePreferences().getTheme() ? Colors.white : Colors.black,
                )
            ),
          ),
          child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder <List<Game>> (
          future: futureGames,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text('No results found');
              }
              else {
                return SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var game in snapshot.data!)
                        GameCard(game: game),
                    ],
                  ),
                );
              }
            }
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
                child: SizedBox(
                    height: 300,
                    width: 275,
                    child: Transform.scale(
                        scale: 0.2,
                        child: const CircularProgressIndicator(
                          strokeWidth: 20,
                          color: Color(0xff1F2D5A),
                        )
                    )
                ),
            );
          },
        ),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.white,
        boxShadow: const <BoxShadow> [
          BoxShadow(
            color: Color(0x6fa4a4a2),
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 1,
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Expanded(
            flex: 7,
            child: FittedBox(
              fit: BoxFit.fill,
              child: CachedNetworkImage(
                imageUrl: game.image,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded (
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack (
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        color: Colors.green,
                        height: 35,
                        width: 35,
                      ),
                      Positioned(
                        right: 2,
                        child: Text(
                            '${game.rating}',
                            style: const TextStyle (
                              color: Colors.white,
                            ),
                        ),
                      ),
                    ]
                ),
              )
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                game.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle (
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
