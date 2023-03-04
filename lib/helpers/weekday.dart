import 'dart:ui';

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
        colour = const Color.fromRGBO(214, 40, 40, 1);
        break;
      case 1:
        short = 'MON';
        long = 'Monday';
        colour = const Color.fromRGBO(0, 48, 73, 1);
        break;
      case 2:
        short = 'TUE';
        long = 'Tuesday';
        colour = const Color.fromRGBO(0, 48, 73, 1);
        break;
      case 3:
        short = 'WED';
        long = 'Wednesday';
        colour = const Color.fromRGBO(0, 48, 73, 1);
        break;
      case 4:
        short = 'THU';
        long = 'Thursday';
        colour = const Color.fromRGBO(0, 48, 73, 1);
        break;
      case 5:
        short = 'FRI';
        long = 'Friday';
        colour = const Color.fromRGBO(252, 191, 73, 1);
        break;
      case 6:
        short = 'SAT';
        long = 'Saturday';
        colour = const Color.fromRGBO(247, 127, 0, 1);
        break;
    }
  }
}
