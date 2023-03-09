import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeTypography {
  static TextStyle gFonts(String name, double size, FontWeight weight, Color colour) {
    return GoogleFonts.getFont(name, fontSize: size, fontWeight: weight, color: colour);
  }
}

/*
BodyMedium = Text




*/
