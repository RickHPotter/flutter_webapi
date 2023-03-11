import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_webapi_first_course/theme/theme_colours.dart';

class ThemeTypography {
  static TextStyle gFonts(String name, double size, FontWeight weight, Color colour) {
    return GoogleFonts.getFont(name, fontSize: size, fontWeight: weight, color: colour);
  }

  static TextStyle abelWhite = ThemeTypography.gFonts('Abel', 16, FontWeight.w600, Colors.white);
  static TextStyle abelWatermelon = ThemeTypography.gFonts('Abel', 16, FontWeight.w600, ThemeColours.primaryColour);
  static TextStyle rajdhaniPrimary = ThemeTypography.gFonts('Rajdhani', 24, FontWeight.w500, ThemeColours.primaryColour);

}