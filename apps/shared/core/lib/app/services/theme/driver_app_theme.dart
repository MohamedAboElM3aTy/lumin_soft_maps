import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData driverAppTheme() {
  return ThemeData(
    colorSchemeSeed: const Color.fromARGB(255, 4, 226, 242),
    fontFamily: GoogleFonts.lato().fontFamily,
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
