import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass{
/*
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
      )
  );*/

  static Color primaryColor = HexColor('#0076FF');
  static Color secondColor  = HexColor('#4795EE');
  static Color thirdColor   = HexColor('#006DEB');
  static Color fourthColor  = HexColor('#20436B');
  static Color fifthColor   = HexColor('#0056B8');

  static AppBarTheme appBarTema = AppBarTheme(
      color: HexColor('#1C1C1C'),
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
      )
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor('#333536'),
      colorScheme: ColorScheme.dark(),
      appBarTheme: appBarTema
  );


/*

  */
/*
  final inputTema = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: primaryDark
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: primaryLight
        ),
        borderRadius: BorderRadius.circular(20)
    ),
  );

  const textTema = TextTheme(
      headline1: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: primaryDark
      ),
      bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.black
      )
  );

  final botaoQuadradoTema = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(fontSize: 28, color: Colors.white),
      )
  );
*/
/*  static ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorDark: primaryDark,
  primaryColorLight: primaryLight,
  appBarTheme: appBarTema,
  inputDecorationTheme: inputTema,
  textTheme: textTema,
  elevatedButtonTheme: botaoQuadradoTema
  );*/


}