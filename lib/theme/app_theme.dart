import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color primary = Colors.blue[900];
  static final Color secondary = Colors.blue;
  static final Color accent = Colors.blue[900];


  static final ThemeData lightTheme = ThemeData(
    canvasColor: Colors.grey.shade300,
    primaryColor: primary,
    accentColor: primary,
    buttonColor: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            headline6: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.black,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    iconTheme: IconThemeData(color: primary),
    colorScheme: ColorScheme.light(
      //used in buttons
      primary: primary,
      secondary: secondary,

      onPrimary: Colors.white,
      background: Colors.grey.shade300,
      //used for posts
      onSurface: Colors.grey[700],
      onBackground: Colors.grey[600],
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(color: Colors.black),
          subtitle2: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
        ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.grey[850],
    primaryColor: Colors.teal,
    accentColor: Colors.amber,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
    ),
    colorScheme: ColorScheme.dark(
      //used for profile screen dot color
      primary: Colors.white54,
      //used for color of notes list tile
      onPrimary: Colors.grey[300],
      secondary: Color(0xfff29a94),
      background: Colors.grey[800],
      onSurface: Colors.white60,
      onBackground: Colors.grey,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    accentIconTheme: IconThemeData(color: Colors.grey[850]),
    textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(color: Colors.white, fontSize: 20),
          subtitle2: TextStyle(color: Colors.white, fontSize: 20),
          headline5: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: Colors.white),
          headline4: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white),
          button: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          headline6: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          bodyText2: TextStyle(color: Colors.white),
        ),
  );
}
