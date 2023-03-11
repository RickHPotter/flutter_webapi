import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/theme/theme_colours.dart';
import 'package:flutter_webapi_first_course/theme/theme_typography.dart';

ThemeData myTheme = ThemeData(
    // APPBAR
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle (
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(color: ThemeColours.secondaryColour),
      toolbarHeight: 56,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // COLOURS
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: ThemeColours.primaryColour, onPrimary: ThemeColours.primaryColour,
        secondary: Colors.pink.shade50, onSecondary: Colors.pink.shade50,
        error: Colors.red, onError: Colors.red,
        background: Colors.white, onBackground: Colors.transparent,
        surface: Colors.black, onSurface: Colors.black,

    ),

    cardColor: const Color.fromRGBO(75, 75, 75, 1),

    // TYPOGRAPHY
    textTheme: TextTheme(
      titleLarge: ThemeTypography.gFonts('Quicksand', 26, FontWeight.w600, Colors.white),
      titleMedium: ThemeTypography.gFonts('Handlee', 22, FontWeight.w400, Colors.white),
      titleSmall: ThemeTypography.gFonts('Quicksand', 14, FontWeight.w300, Colors.white),

      bodyLarge: ThemeTypography.gFonts('Fira Code', 26, FontWeight.w600, Colors.white),
      bodyMedium: ThemeTypography.gFonts('Fira Code', 16, FontWeight.w400, Colors.white),
      bodySmall: ThemeTypography.gFonts('Fira Code', 12, FontWeight.w700, Colors.white),

      labelLarge: ThemeTypography.gFonts('Sora', 12, FontWeight.w400, Colors.white),  // slidable is unchangeable about being a labelLarge
      labelMedium: ThemeTypography.gFonts('Sora', 16, FontWeight.w600, Colors.white),
      labelSmall: ThemeTypography.gFonts('Sora', 16, FontWeight.w300, Colors.white),

      headlineLarge: ThemeTypography.gFonts('Macondo', 26, FontWeight.w400, Colors.white),
      headlineMedium: ThemeTypography.gFonts('Macondo', 22, FontWeight.w300, Colors.white),

    )
);
