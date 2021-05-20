import 'package:flutter/material.dart';

const kPrimaryLightColor = Color(0xFFB32929);
LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0xFF827F9), Color(0xFF2F80ED)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xff1F2230);
const kGreen = Color(0xFF01CC97);
const kAnimationDuration = Duration(milliseconds: 200);
const kScaffoldColor = Color(0xff191A1D);

LinearGradient kIndicatorGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF827F9), Color(0xFF2F80ED)],
);

Map<int, Color> color2 = {
  50: Color(0xFF3C8AF0).withOpacity(0.1),
  100: Color(0xFF3C8AF0).withOpacity(0.2),
  200: Color(0xFF3C8AF0).withOpacity(0.3),
  300: Color(0xFF3C8AF0).withOpacity(0.4),
  400: Color(0xFF3C8AF0).withOpacity(0.5),
  500: Color(0xFF3C8AF0).withOpacity(0.6),
  600: Color(0xFF3C8AF0).withOpacity(0.7),
  700: Color(0xFF3C8AF0).withOpacity(0.8),
  800: Color(0xFF3C8AF0).withOpacity(0.9),
  900: Color(0xFF3C8AF0),
};

// List<Color> playlistColors = [
//   scheme1,
//   scheme2,
//   scheme3,
//   scheme4,
//   scheme5,
//   scheme6,
//   scheme7,
//   scheme8,
//   scheme9,
//   scheme10,
//   scheme11,
//   scheme12,
// ];

Map<String, Color> playlistColors = {
  "scheme1": scheme1,
  "scheme2": scheme2,
  "scheme3": scheme3,
  "scheme4": scheme4,
  "scheme5": scheme5,
  "scheme6": scheme6,
  "scheme7": scheme7,
  "scheme8": scheme8,
  "scheme9": scheme9,
  "scheme10": scheme10,
  "scheme11": scheme11,
  "scheme12": scheme12,
};

const scheme1 = Color(0xff6FCF97);
const scheme2 = Color(0xffF1AB9F);
const scheme3 = Color(0xffFD9D28);
const scheme4 = Color(0xff36ADF1);
const scheme5 = Color(0xff6964C8);
const scheme6 = Color(0xff18BCBC);
const scheme7 = Color(0xff5E04B7);
const scheme8 = Color(0xff01CC97);
const scheme9 = Color(0xff365FF1);
const scheme10 = Color(0xffF136D3);
const scheme11 = Color(0xffF5BF02);
const scheme12 = Color(0xffD302F5);
// 0xff4eda23
MaterialColor kPrimaryColor = MaterialColor(0xFF3C8AF0, color2);
