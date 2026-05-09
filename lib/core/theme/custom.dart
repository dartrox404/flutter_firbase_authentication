import 'package:flutter/material.dart';

class Custom {
  static final ThemeData apptheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xff14213d),
      secondary: Color(0xff000000),
      inversePrimary: Color(0xfffca311),
      surface: Color(0xffffffff),
      tertiary: Colors.grey,
      inverseSurface: Color(0xffe5e5e5),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontFamily: 'poppins'),
      headlineMedium: TextStyle(fontSize: 28, fontFamily: 'poppins'),
      headlineSmall: TextStyle(fontSize: 20, fontFamily: 'poppins'),
      bodyLarge: TextStyle(fontSize: 18, fontFamily: 'manrope'),
      bodyMedium: TextStyle(fontSize: 16, fontFamily: 'manrope'),
      bodySmall: TextStyle(fontSize: 14, fontFamily: 'manrope'),
    ),
  );
}
