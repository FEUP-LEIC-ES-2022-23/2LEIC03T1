import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/themePrefs.dart';

ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color.fromRGBO(31, 45, 90, 1) ,

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

);
ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromRGBO(31, 45, 90, 1) ,
  primaryColor: Colors.white ,
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

);
