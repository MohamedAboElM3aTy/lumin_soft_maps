import 'package:core/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    colorSchemeSeed: AppColors.seedColor,
    fontFamily: GoogleFonts.lato().fontFamily,
    textTheme: GoogleFonts.latoTextTheme(),
  );
}