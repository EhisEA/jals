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
// 0xff4eda23
MaterialColor kPrimaryColor = MaterialColor(0xFF3C8AF0, color2);
