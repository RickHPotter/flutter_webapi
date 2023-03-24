import 'package:flutter/material.dart';

class ThemeColours {
  
  // colour factory
  static const Map<int, Color> blueish =
  {
    50: Color.fromRGBO(0, 48, 73, 0.1),
    100:Color.fromRGBO(0, 48, 73, 0.2),
    200:Color.fromRGBO(0, 48, 73, 0.3),
    300:Color.fromRGBO(0, 48, 73, 0.4),
    400:Color.fromRGBO(0, 48, 73, 0.5),
    500:Color.fromRGBO(0, 48, 73, 0.6),
    600:Color.fromRGBO(0, 48, 73, 0.7),
    700:Color.fromRGBO(0, 48, 73, 0.8),
    800:Color.fromRGBO(0, 48, 73, 0.9),
    900:Color.fromRGBO(0, 48, 73, 1.0),
  };
  static const MaterialColor primaryColour = MaterialColor(0xFF003366, blueish);

  static const Map<int, Color> redish =
  {
    50: Color.fromRGBO(255, 62, 23, 0.1),
    100:Color.fromRGBO(255, 62, 23, 0.2),
    200:Color.fromRGBO(255, 62, 23, 0.3),
    300:Color.fromRGBO(255, 62, 23, 0.4),
    400:Color.fromRGBO(255, 62, 23, 0.5),
    500:Color.fromRGBO(255, 62, 23, 0.6),
    600:Color.fromRGBO(255, 62, 23, 0.7),
    700:Color.fromRGBO(255, 62, 23, 0.8),
    800:Color.fromRGBO(255, 62, 23, 0.9),
    900:Color.fromRGBO(255, 62, 23, 1.0),
  };
  static const MaterialColor secondaryColour = MaterialColor(0xDDFF3E17, redish);

  static const Map<int, Color> weekdays =
  {
    600:Color.fromRGBO(255, 249, 167, 1), // WEEKDAYS
    700:Color.fromRGBO(255, 194, 19, 1), // FRIDAY
    800:Color.fromRGBO(247, 126, 33, 1), // SATURDAY
    900:Color.fromRGBO(214, 28, 78, 1), // SUNDAY
  };

  static const colourDots = {
    'ballyhoo': Color.fromRGBO(88, 168, 59, 1.0),
    'basketball': Color.fromRGBO(238, 103, 48, 1.0),
  };

}