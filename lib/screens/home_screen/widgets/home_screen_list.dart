import '../../../models/journal.dart';
import 'journal_card.dart';

// static methods
int diffInDays (DateTime date1, DateTime date2) {
  return (
      (date1.difference(date2) - Duration(hours: date1.hour)
      + Duration(hours: date2.hour)).inHours / 24
  ).round();
}

List<JournalCard> generateListJournalCards(
    {
      required DateTime currentDay,
      required Map<String, Journal> database,
      required Function refreshFunction
    }) {

  Duration week = const Duration(days: 7);

  // creation of the returning List<JournalCard> and a helper map
  List<JournalCard> list = [];
  Map<int, List<Journal>> sortedList = {0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6:[]};

  // populating the helper map
  database.forEach((key, value) {
    DateTime date = value.createdAt;

    bool isInRange = date.isAfter(currentDay.subtract(week));
    if (isInRange) {
      int difference = diffInDays(date, currentDay).abs();
      sortedList[difference]?.add(value);
    }
  });

  // adding JournalCards to every day of the last 7
  for (int i = 0; i < 7; i++) {
    JournalCard journalCard;

    // in case there's no diary entry, then a blank journal card is added
    if (sortedList[i] == null || sortedList[i]!.isEmpty) {
      journalCard = JournalCard(
        showedDate: currentDay.subtract(Duration(days: i)),
        refreshFunction: refreshFunction,
      );
      list.add(journalCard);
    }
    // otherwise, one or more filled-in journal cards are added
    else {
      for (int j = sortedList[i]!.length - 1; j >= 0; j--) {
        journalCard = JournalCard(
          showedDate: currentDay.subtract(Duration(days: i)),
          refreshFunction: refreshFunction,
          journal: sortedList[i]![j],
        );
        list.add(journalCard);
      }
    }
  }

  return list;
}
