import 'dart:ui';

import 'package:flutter_webapi_first_course/theme/theme_colours.dart';

class WeekDay {
  int weekday;
  late String short;
  late String long;
  late Color colour;

  WeekDay(this.weekday) {
    switch (weekday) {
      case 7:
        short = 'SUN';
        long = 'Sunday';
        colour = ThemeColours.weekdays[900]!;
        break;
      case 1:
        short = 'MON';
        long = 'Monday';
        colour = ThemeColours.weekdays[600]!;
        break;
      case 2:
        short = 'TUE';
        long = 'Tuesday';
        colour = ThemeColours.weekdays[600]!;
        break;
      case 3:
        short = 'WED';
        long = 'Wednesday';
        colour = ThemeColours.weekdays[600]!;
        break;
      case 4:
        short = 'THU';
        long = 'Thursday';
        colour = ThemeColours.weekdays[600]!;
        break;
      case 5:
        short = 'FRI';
        long = 'Friday';
        colour = ThemeColours.weekdays[700]!;
        break;
      case 6:
        short = 'SAT';
        long = 'Saturday';
        colour = ThemeColours.weekdays[800]!;
        break;
    }
  }
}
