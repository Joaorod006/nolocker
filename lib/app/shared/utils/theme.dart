import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constantes.dart';

final ThemeData darkThemeData = ThemeData(
  useMaterial3: true, // Habilitar o Material 3
  colorScheme: const ColorScheme.dark(
    primary: kNeutral,
    secondary: kContrastSoft,
    surface: kContrast,
    onSurface: kNeutral,
  ),
  brightness: Brightness.dark,
  // scaffoldBackgroundColor: kContrast,
  fontFamily: 'Poppins',
  textTheme: _textTheme(),
  inputDecorationTheme: InputDecorationTheme(
    outlineBorder: BorderSide(color: Colors.transparent),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),

    // focusedBorder: InputBorder.none,
    // enabledBorder: InputBorder.none,
    // errorBorder: InputBorder.none,
    // disabledBorder: InputBorder.none,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    fillColor: kNeutralSoft,
  ),

  iconButtonTheme: _iconButtonThemeData(),
);

TextTheme _textTheme() {
  return GoogleFonts.poppinsTextTheme(Typography.whiteMountainView);
}

IconButtonThemeData _iconButtonThemeData() {
  return IconButtonThemeData(
    style: IconButton.styleFrom(
        // focusColor: kBFNeutralSoft,
        // surfaceTintColor: kBFNeutralSoft,
        // backgroundColor: kBFLaranjaSoft,
        // highlightColor: kBFNeutralSoft,
        // foregroundColor: kBFLaranja,
        ),
  );
}
