import '../../../models/journal.dart';
import 'journal_card_view.dart';

List<JournalCardView> generateListJournalCardsView(
    {required List<Journal> database,}) {

  List<JournalCardView> list = [];

  for (int c = 0; c < database.length; c++) {
    JournalCardView view = JournalCardView(journal: database[c]);
    list.add(view);
  }

  return list;
}
