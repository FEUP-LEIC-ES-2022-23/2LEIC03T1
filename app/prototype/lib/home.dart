import 'package:flutter/material.dart';
import 'package:prototype/components/light_night_mode_widget.dart';
import 'package:prototype/search.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/user.dart';
import 'consts/theme_data.dart';
import 'models/game_model.dart';
import 'services/api_requests.dart';

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
          backgroundColor: Colors.pink,
          title: const Text('GameShare'),
          flexibleSpace: light_night_mode_widget(),
        ),
        body: Scaffold(
          body: Scaffold(
            body: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GameSection(title: 'Test'),
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
              selectedItemColor: Colors.green,
              onTap: (int index) {
                switch (index) {
                  case 0:
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const SearchScreen(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const UserScreen(),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
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

  const GameSection({Key? key, required this.title}) : super(key: key);

  @override
  State<GameSection> createState() => _GameSectionState();
}

class _GameSectionState extends State<GameSection> {
  late Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget> [
        Text(widget.title),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: FutureBuilder <List<Game>> (
            future: futureGames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Text('No results found');
                }
                else {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    children: [
                      for (var game in snapshot.data!)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget> [
                              Expanded(
                                child: Image.network(
                                  game.image,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('${game.rating}'),
                              const SizedBox(height: 10),
                              Text(
                                game.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle (fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ]
                  );
                }
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
