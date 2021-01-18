import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class MyTheme {
  TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    headline2: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    headline3: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    headline4: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    headline5: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    headline6: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    button: GoogleFonts.sourceSansPro(),
    overline: GoogleFonts.sourceSansPro(),
    caption: GoogleFonts.sourceSansPro(),
    subtitle1: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
    bodyText1: GoogleFonts.sourceSansPro(),
    bodyText2: GoogleFonts.sourceSansPro(),
  ).apply(
    bodyColor: kTextColor,
  );
  final themeData = ThemeData(
    textTheme: TextTheme(
      headline1: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      headline2: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      headline3: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      headline4: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      headline5: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      headline6: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      button: GoogleFonts.sourceSansPro(),
      overline: GoogleFonts.sourceSansPro(),
      caption: GoogleFonts.sourceSansPro(),
      subtitle1: GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
      bodyText1: GoogleFonts.sourceSansPro(),
      bodyText2: GoogleFonts.sourceSansPro(),
    ).apply(
      bodyColor: kTextColor,
    ),
    iconTheme: IconThemeData(color: kTextColor),
    // brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    accentColor: kPrimaryColor,
    indicatorColor: kPrimaryColor,
    toggleableActiveColor: kPrimaryColor,
    // scaffoldBackgroundColor: kScaffoldColor,
    appBarTheme: AppBarTheme(
        elevation: 0,
        textTheme: TextTheme(
          headline1:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          headline2:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          headline3:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          headline4:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          headline5:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          headline6:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          button: GoogleFonts.sourceSansPro(),
          overline: GoogleFonts.sourceSansPro(),
          caption: GoogleFonts.sourceSansPro(),
          subtitle1:
              GoogleFonts.sourceSansPro(), //TextStyle(fontFamily: "brown"),
          bodyText1: GoogleFonts.sourceSansPro(),
          bodyText2: GoogleFonts.sourceSansPro(),
        ).apply(
          bodyColor: kTextColor,
        ),
        centerTitle: true,
        color: Colors.white),
  );
}
