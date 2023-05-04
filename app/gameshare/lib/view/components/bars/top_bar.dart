import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/providers/scroll_provider.dart';
import 'light_dark_mode_button.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  ScrollController scrollController = ScrollProvider().controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1B274B),
      flexibleSpace: const LightDarkModeButton(),
      leading: Container(
        margin: const EdgeInsets.only(
            left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
        child: Image.asset(
          'assets/images/logo.png',
          key: Key("Logo"),
          scale: 1,
        ),
      ),
      centerTitle: true,
      title: TextButton(
        onPressed: _scrollToTop,
        child: Text(
          "GAMESHARE",
          style: GoogleFonts.montserratAlternates(
            textStyle: const TextStyle(color: Color(0xff08C076)),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
