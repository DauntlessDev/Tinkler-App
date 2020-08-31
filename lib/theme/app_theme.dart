import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final Color primary = Colors.blue[900];
  static final Color secondary = Colors.blue;
  static final Color accent = Colors.blue[900];

  static final Color whiteColor = Colors.grey[100];

  static final ThemeData lightTheme = ThemeData(
    canvasColor: Colors.grey.shade300,
    primaryColor: primary,
    accentColor: primary,
    buttonColor: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteColor,
    backgroundColor: whiteColor,
    appBarTheme: AppBarTheme(
      color: whiteColor,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
            headline6: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: whiteColor,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    iconTheme: IconThemeData(color: primary),
    colorScheme: ColorScheme.light(
      //used in buttons
      primary: primary,
      secondary: secondary,

      onPrimary: whiteColor,
      onSecondary: Colors.grey,
      background: Colors.grey.shade300,
      //used for posts
      onSurface: Colors.grey[300],
      onBackground: Colors.grey[300],
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 35,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 25,
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
      //used for email textstyle in profile
      subtitle1: TextStyle(fontSize: 15, color: Colors.black54),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: whiteColor,
      titleTextStyle: TextStyle(color: Colors.black),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    canvasColor: Colors.grey.shade300,
    primaryColor: primary,
    accentColor: primary,
    buttonColor: Colors.blue,
    // brightness: Brightness.light,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline1: TextStyle(
                color: whiteColor, fontWeight: FontWeight.bold, fontSize: 25),
            headline6: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: whiteColor,
            ),
          ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: whiteColor,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    iconTheme: IconThemeData(color: primary),
    colorScheme: ColorScheme.dark(
      //used in buttons
      primary: primary,
      secondary: secondary,

      //comments color
      onPrimary: whiteColor,
      onSecondary: Colors.grey,

      background: Colors.grey.shade300,
      //used for posts
      onSurface: Colors.grey[850],
      onBackground: Colors.grey[600],
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
          headline1: TextStyle(
              color: whiteColor,
              fontFamily: 'Montserrat',
              fontSize: 35,
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
            color: whiteColor,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          bodyText1: TextStyle(color: whiteColor),
          bodyText2: TextStyle(
            color: whiteColor,
            // fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(color: whiteColor),
          subtitle2: TextStyle(color: whiteColor),
          button: TextStyle(color: whiteColor),
        ),
    primaryTextTheme: TextTheme(
      //used for email textstyle in profile
      subtitle1: TextStyle(fontSize: 15, color: Colors.white54),
    ),
    // for inputtextfield icon theme
    accentIconTheme: IconThemeData(color: Colors.grey),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[400],
      titleTextStyle: TextStyle(color: Colors.black),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
  );
}
