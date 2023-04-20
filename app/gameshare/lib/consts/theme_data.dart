import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';



ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: MyAppColors.midnightBlue,
  backgroundColor: Colors.white,

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
  )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor:  MyAppColors.lightGreen,
    unselectedItemColor:  MyAppColors.lightBlue,
  ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyAppColors.lightBlue,
    ),
  shadowColor: MyAppColors.grey,
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: MyAppColors.lightGrey,
  ),
  accentColor: MyAppColors.purple,

  elevatedButtonTheme:  ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStatePropertyAll<Size >(Size(140,40)),
      backgroundColor: MaterialStatePropertyAll<Color>(MyAppColors.aquaBlue),
    )
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.montserratAlternates(),
  )



);

ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyAppColors.midnightBlue ,
  primaryColor: Colors.white ,
  backgroundColor: MyAppColors.darkBlue,
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
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor:  MyAppColors.lightGreen,
    unselectedItemColor:  MyAppColors.lightBlue,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: MyAppColors.lightGreen,
  ),
  shadowColor: MyAppColors.darkGrey,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyAppColors.darkBlue,
    ),
  accentColor: MyAppColors.lightGreen,
    elevatedButtonTheme:  const ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStatePropertyAll<Size >(Size(140,40)),
          backgroundColor: MaterialStatePropertyAll<Color>(MyAppColors.aquaGreen),
        )
    ),

    textTheme: TextTheme(
      bodyMedium: GoogleFonts.montserratAlternates(),
)

);
