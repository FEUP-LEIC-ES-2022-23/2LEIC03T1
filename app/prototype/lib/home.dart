import 'package:flutter/material.dart';
import 'package:prototype/components/light_night_mode_widget.dart';
import 'package:prototype/search.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/user.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';

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
          backgroundColor: const Color(0xff1B274B),
          title: const Text('GameShare'),
          flexibleSpace: LightNightModeWidget(),
        ),
        body: Scaffold(
          body: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
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
