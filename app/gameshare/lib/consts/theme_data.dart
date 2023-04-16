import 'package:flutter/material.dart';
import 'package:gameshare/consts/app_colors.dart';



ThemeData lightTheme=ThemeData(
  //Remover?
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
  accentColor: MyAppColors.purple, //Remover
  colorScheme: ColorScheme(
      brightness: Brightness.light,

      primary: MyAppColors.darkBlue,
      onPrimary: MyAppColors.lightGreen,

      secondary: MyAppColors.purple,
      onSecondary: Colors.white,

      error: Colors.red, //mudar possivelmente
      onError: Colors.white, //mudar tbm

      background: Colors.white,
      onBackground: Colors.black,

      surface: Colors.white, //mudar (possivelmente)
      onSurface: Colors.black, //mudar tbm

      //Não Obrigatorios (podem ser removidos)
      shadow: MyAppColors.grey,
      primaryContainer: Colors.white,
      onPrimaryContainer: Colors.black,
  )


);

ThemeData darkTheme=ThemeData(
  //Remover?
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
  accentColor: MyAppColors.lightGreen, //Remover
  colorScheme: ColorScheme(
      brightness: Brightness.dark,

      primary: MyAppColors.darkBlue,
      onPrimary: MyAppColors.lightGreen,

      secondary: MyAppColors.purple,
      onSecondary: Colors.white,

      error: Colors.red, //mudar possivelmente
      onError: Colors.white, //mudar possivelmente

      background: MyAppColors.midnightBlue,
      onBackground: Colors.white,

      surface: MyAppColors.midnightBlue, //mudar (possivelmente)
      onSurface: Colors.white, //mudar tbm


      //Não Obrigatórios (podem ser removidos)
      shadow: MyAppColors.grey,
      primaryContainer: MyAppColors.midnightBlue,
      onPrimaryContainer: Colors.white,

      secondaryContainer: MyAppColors.lightGreen,
      onSecondaryContainer: Colors.white
  )
);