import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: MyAppColors.midnightBlue,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: MyAppColors.darkBlue,
      titleTextStyle: TextStyle(
        color: MyAppColors.lightGreen,
        fontSize: 25,
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
      iconColor: MaterialStatePropertyAll<Color>(MyAppColors.lightBlue),
      iconSize: MaterialStatePropertyAll<double>(30),
    )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: MyAppColors.lightGreen,
      unselectedItemColor: MyAppColors.lightBlue,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyAppColors.lightBlue,
    ),
    shadowColor: MyAppColors.grey,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: MyAppColors.lightGrey,
    ),
    dividerColor: MyAppColors.darkGrey,
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll<Size>(Size(140, 40)),
        backgroundColor: MaterialStatePropertyAll<Color>(MyAppColors.aquaBlue),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium:
          GoogleFonts.montserratAlternates(fontWeight: FontWeight.normal),
      bodyLarge: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),
      bodySmall: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w100),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: MyAppColors.darkBlue,
      onPrimary: MyAppColors.lightGreen,

      secondary: MyAppColors.purple,
      onSecondary: Colors.white,

      error: Colors.red,
      //mudar possivelmente
      onError: Colors.white,
      //mudar possivelmente

      background: Colors.white,
      onBackground: Colors.black,

      surface: Colors.white,
      //mudar possivelmente
      onSurface: Colors.black,
      //mudar possivelmente

      onPrimaryContainer: MyAppColors.white,
      primaryContainer: MyAppColors.white,

      secondaryContainer: MyAppColors.lightGrey,
    ));

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: MyAppColors.midnightBlue,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: MyAppColors.darkBlue,
    titleTextStyle: TextStyle(
      color: MyAppColors.lightGreen,
      fontSize: 25,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
    iconColor: MaterialStatePropertyAll<Color>(MyAppColors.lightGreen),
    iconSize: MaterialStatePropertyAll<double>(30),
  )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: MyAppColors.lightGreen,
    unselectedItemColor: MyAppColors.lightBlue,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: MyAppColors.lightGreen,
  ),
  shadowColor: MyAppColors.darkGrey,
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: MyAppColors.darkBlue,
  ),
  dividerColor: MyAppColors.white,
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
    minimumSize: MaterialStatePropertyAll<Size>(Size(140, 40)),
    backgroundColor: MaterialStatePropertyAll<Color>(MyAppColors.aquaGreen),
  )),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.montserratAlternates(),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,

    primary: MyAppColors.white,
    onPrimary: MyAppColors.lightGreen,

    secondary: MyAppColors.lightGreen,
    onSecondary: Colors.white,

    error: Colors.red,
    //mudar possivelmente
    onError: Colors.white,
    //mudar possivelmente

    background: MyAppColors.midnightBlue,
    onBackground: Colors.white,

    surface: MyAppColors.midnightBlue,
    //mudar possivelmente
    onSurface: Colors.white,
    //mudar possivelmente

    onPrimaryContainer: MyAppColors.darkBlue,
    primaryContainer: MyAppColors.darkBlue,
    secondaryContainer: MyAppColors.darkBlue,
  ),
);
