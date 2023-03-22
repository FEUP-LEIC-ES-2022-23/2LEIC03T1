import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData mainTheme(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Color.fromRGBO(31, 45, 90, 1) :Colors.white,
      primaryColor: isDarkTheme ? Colors.white:Color.fromRGBO(31, 45, 90, 1) ,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B274B),
        titleTextStyle: TextStyle(
          color: Color(0xff08C076),
          fontSize: 25,
        ),

      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll<Color>(Color(0xff08C076)),
          iconSize: MaterialStatePropertyAll<double>(30),
        )
      ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light(),
      ),
      //colorScheme: isDarkTheme ? ColorScheme.dark(primary: Color(0xff08C076) ) : ColorScheme.light(primary: Color(0xff08C076)),

    );
  }
}