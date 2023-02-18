class WeekDay {
  int weekday;
  late String short;
  late String long;

  WeekDay(this.weekday) {
    switch (weekday) {
      case 7:
        short = 'SUN';
        long = 'Sunday';
        break;
      case 1:
        short = 'MON';
        long = 'Monday';
        break;
      case 2:
        short = 'TUE';
        long = 'Tuesday';
        break;
      case 3:
        short = 'WED';
        long = 'Wednesday';
        break;
      case 4:
        short = 'THU';
        long = 'Thursday';
        break;
      case 5:
        short = 'FRI';
        long = 'Friday';
        break;
      case 6:
        short = 'SAT';
        long = 'Saturday';
        break;
    }
  }
}
