import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Res/colors/app_colors.dart';

class AppTextStyles {
  static TextStyle headerTextStyle({Color color = Colors.white, double size = 25}) {
    return GoogleFonts.signikaNegative(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle montserratStyle(
      {required Color color, required double fontSize}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
    );
  }

  static TextStyle headingStyles(
      {double fontSize = 36, Color color = Colors.white}) {
    return GoogleFonts.rubikMoonrocks(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 2,
    );
  }

  static TextStyle normalStyle(
      {Color color = Colors.white, double fontSize = 16}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
      letterSpacing: 1.7,
      height: 1.5,
    );
  }

  static TextStyle readableStyle(
      {Color color = Colors.black, double fontSize = 16}) {
    return GoogleFonts.rubik(
        letterSpacing: 1,
        fontSize: fontSize,
        color: color);
  }
}
