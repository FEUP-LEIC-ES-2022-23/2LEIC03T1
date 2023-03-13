import 'package:flutter/material.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:prototype/auth.dart';
import 'package:prototype/user.dart';
import 'package:prototype/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'components/light_night_mode_widget.dart';
import 'consts/theme_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selected = 1;
  final User? user = Auth().user;
  final TextEditingController controller = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  // store the value of the test string in the database
  Object? _testString;

  void _loadTestString() async {
    final snapshot = await ref.child('test').get();
    setState(() {
      if (snapshot.exists) {
        _testString = snapshot.value;
      } else {
        _testString = 'No data';
      }
    });
  }

  @override
  void initState() {
    _loadTestString();
    super.initState();
  }

  Widget _title(String title, Color themeColor) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: themeColor,
      ),
    );
  }

  Widget _entryField(String title, Color themeColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(title, themeColor),
          TextField(
            style: TextStyle(color: themeColor),
            cursorColor: themeColor,
            controller: controller,
            decoration: InputDecoration(
              hintText: 'send something to register in the database',
              hintStyle: TextStyle(color: themeColor),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: themeColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        // submit controller text to database
        ref.child('test').set(controller.text);

        // clear controller text
        controller.clear();

        // navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xff1B274B),
        ),
        child: const Text(
          'Send',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 150,
                  ),
                  Column(
                    children: <Widget>[
                      _entryField(
                          'Input',
                          DarkThemePreferences().getTheme()
                              ? Colors.white
                              : const Color(0xff1B274B)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Database value: $_testString',
                    style: TextStyle(
                      color: DarkThemePreferences().getTheme()
                          ? Colors.white
                          : const Color(0xff1B274B),
                    ),
                  ),
                ],
              ),
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
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                  break;
                case 1:
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
    );
  }
}
