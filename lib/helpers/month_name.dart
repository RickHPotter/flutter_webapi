class Month {
  String month;
  late String short;
  late String long;

  Month(this.month) {
    switch (month) {
      case "1":
        short = 'JAN';
        long = 'Janvier';
        break;
      case "2":
        short = 'FEV';
        long = 'Février';
        break;
      case "3":
        short = 'MAR';
        long = 'Mars';
        break;
      case "4":
        short = 'AVR';
        long = 'Avril';
        break;
      case "5":
        short = 'MAY';
        long = 'May';
        break;
      case "6":
        short = 'JUN';
        long = 'June';
        break;
      case "7":
        short = 'JUI';
        long = 'Juillet';
        break;
      case "8":
        short = 'AOU';
        long = 'Aôut';
        break;
      case "9":
        short = 'SEP';
        long = 'Septembre';
        break;
      case "10":
        short = 'OCT';
        long = 'Octobre';
        break;
      case "11":
        short = 'NOV';
        long = 'Novembre';
        break;
      case "12":
        short = 'DEC';
        long = 'Decembre';
        break;
    }
  }
}