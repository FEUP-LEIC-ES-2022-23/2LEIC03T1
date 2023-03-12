import 'package:flutter/material.dart';
import 'package:prototype/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prototype/login_page.dart';
import 'package:prototype/search.dart';
import 'package:prototype/home.dart';
import 'package:prototype/components/light_night_mode_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final User? user = Auth().user;
  int _selected = 2;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: user?.email ?? 'No User',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
    );
  }

  Widget _signInButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 2)),
        child: const Text('Sign in',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _signOutButton() {
    return InkWell(
      onTap: () async {
        await signOut();
        // there must be a better way to do this
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 2)),
        child: const Text('Sign out',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('GameShare'),
          flexibleSpace: LightNightModeWidget(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _userUid(),
              user != null ? _signOutButton() : _signInButton(),
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
          selectedItemColor: Colors.pink,
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            }
            setState(() {
              _selected = index;
            });
          },
        ));
  }
}
