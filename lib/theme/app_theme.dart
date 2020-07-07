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
    backgroundColor: Colors.white,
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
      foregroundColor: Colors.white,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    iconTheme: IconThemeData(color: primary),
    colorScheme: ColorScheme.light(
      //used in buttons
      primary: primary,
      secondary: secondary,

      onPrimary: Colors.white,
      onSecondary: Colors.grey,
      background: Colors.grey.shade300,
      //used for posts
      onSurface: Colors.grey.shade100,
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
    primaryTextTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 12, color: Colors.black54),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    canvasColor: Colors.grey.shade300,
    primaryColor: primary,
    accentColor: primary,
    buttonColor: Colors.blue,
    brightness: Brightness.light,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            headline6: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    iconTheme: IconThemeData(color: primary),
    colorScheme: ColorScheme.light(
      //used in buttons
      primary: primary,
      secondary: secondary,

      //comments color
      onPrimary: Colors.white,
      onSecondary: Colors.grey,

      background: Colors.grey.shade300,
      //used for posts
      onSurface: Colors.grey[700],
      onBackground: Colors.grey[600],
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
        ),
    primaryTextTheme: TextTheme(
      subtitle1: TextStyle(fontSize: 12, color: Colors.white54),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[400],
      titleTextStyle: TextStyle(color: Colors.black),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );
}
