import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameshare/services/providers/scroll_provider.dart';
import 'package:gameshare/view/screens/search.dart';
import 'package:gameshare/view/screens/user.dart';
import '../../../services/auth.dart';
import '../../screens/home.dart';
import '../../screens/login.dart';
import '../../screens/user.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();

  getSelected() {
    return _selected;
  }

}

int _selected = 0;

class _NavBarState extends State<NavBar> {
  ScrollController scrollController = ScrollProvider().controller;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'User',
          ),
        ],
        currentIndex: _selected,
        backgroundColor: const Color(0xff1B274B),
        onTap: (int index) {
          switch (index) {
            case 0:
              if (_selected == 0) {
                _scrollToTop();
                break;
              }
              _selected = 0;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ____) => const HomePage(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
              break;
            case 1:
              if (_selected == 1) {
                _scrollToTop();
                break;
              }
              _selected = 1;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ____) => const SearchPage(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
              break;
            case 2:
              if (_selected == 2) {
                _scrollToTop();
                break;
              }
              _selected = 2;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ____) => getPageToRedirect()
                  ,
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
              break;
          }
        });
  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  getPageToRedirect() {

    if (Auth().user == null) {
      return LoginPage();
    } else {
      return UserPage(user: Auth().user!.email!, isUser: true);
    }
  }
}