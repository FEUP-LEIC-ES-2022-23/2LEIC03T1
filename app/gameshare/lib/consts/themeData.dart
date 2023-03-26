import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameshare/consts/MyAppColors.dart';

import '../services/themePrefs.dart';

ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: MyAppColors.midnightBlue,

  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: MyAppColors.darkBlue,
    titleTextStyle: TextStyle(
      color: MyAppColors.lightGreen,
      fontSize: 25,
    ),

  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll<Color>(MyAppColors.lightGreen),
      iconSize: MaterialStatePropertyAll<double>(30),
  )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor:  MyAppColors.lightGreen,
    unselectedItemColor:  MyAppColors.lightBlue,
  )

);

ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyAppColors.midnightBlue ,
  primaryColor: Colors.white ,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: MyAppColors.darkBlue,
    titleTextStyle: TextStyle(
      color: MyAppColors.lightGreen,
      fontSize: 25,
    ),

  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll<Color>(MyAppColors.lightGreen),
      iconSize: MaterialStatePropertyAll<double>(30),
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor:  MyAppColors.lightGreen,
    unselectedItemColor:  MyAppColors.lightBlue,
  )

);
