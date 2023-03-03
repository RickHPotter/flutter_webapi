import '../../../models/journal.dart';
import 'journal_card.dart';

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

  Map<int, int> counter = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};
  Duration week = const Duration(days: 7);

  database.forEach((key, value) {
    DateTime date = value.createdAt;
    bool isInRange = date.isAfter(currentDay.subtract(week));

    if (isInRange) {
      int diff = diffInDays(date, currentDay).abs();
      counter[diff] = counter[diff]! + 1;
    }

  });

  List<int> indexation = List.generate(7, (index) => index);


  counter.forEach((key, value) {
      for (int i = 1; i < value; i++) {
        indexation.add(key);
      }
  });

  indexation.sort();

  List<JournalCard> list = [];
  Map<int, List<Journal>> sortedList = {0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6:[]};

  database.forEach((key, value) {
    DateTime date = value.createdAt;

    bool isInRange = date.isAfter(currentDay.subtract(week));
    if (isInRange) {
      int difference = diffInDays(date, currentDay).abs();
      sortedList[difference]?.add(value);
    }
  });

  for (int i = 0; i < indexation.length; i++) {
    JournalCard journalCard;

    if (sortedList[i] == null || sortedList[i]!.isEmpty) {
      journalCard = JournalCard(
        showedDate: currentDay.subtract(Duration(days: i)),
        refreshFunction: refreshFunction,
      );
      list.add(journalCard);
    } else {
      for (int j = 0; j < sortedList[i]!.length; j++) {
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
