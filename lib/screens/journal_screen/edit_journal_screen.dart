import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/widgets/journal_screen.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';

import '../../models/journal.dart';

class EditJournalScreen extends StatelessWidget {
  final Journal journal;
  const EditJournalScreen({Key? key, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JournalScreen(
        journal: journal,
        cont: context,
        httpMethod: updateJournal,
    );
  }

  updateJournal(BuildContext context, String content) async {
    journal.content = content;
    JournalService service = JournalService();
    bool result = await service.patch(journal);

    return result;
  }
}