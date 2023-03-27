import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'light_dark_mode_button.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {

  const TopBar({
    Key? key,

}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1B274B),
      flexibleSpace: const LightDarkModeButton(),
      leading:Container(
        child: Image.asset(
          'assets/images/logo.png',
          scale: 1,
        ),
       margin: const EdgeInsets.only(left:10.0, right:0.0, top:0.0, bottom: 0.0),

      ),

      centerTitle: true,
      title: TextButton(
          onPressed:_scrollToTop,
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

}

//TODO fazer a função que faz com que ao tocar no nome volte ao topo da pagina
void _scrollToTop() {

}
