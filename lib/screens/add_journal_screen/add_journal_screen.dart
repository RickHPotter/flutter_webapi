import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';

import '../../helpers/month_name.dart';
import '../../models/journal.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  AddJournalScreen({Key? key, required this.journal}) : super(key: key);

  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${WeekDay(journal.createdAt.weekday).long}, '
            '${journal.createdAt.year} | '
            '${Month((journal.createdAt.month).toString()).long}, '
            '${journal.createdAt.day.toString().padLeft(2, '0')}. '
        ),
        actions: [
          IconButton(
              onPressed: () {
                var result = registerJournal(context);
                if (context.mounted == true) {
                  Navigator.pop(context, result);
                }
              },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 24),
          minLines: null,
          maxLines: null,
          expands: true,
        ),
      ),
    );
  }

  registerJournal(BuildContext context) async {
    String content = _contentController.text;

    journal.content = content;
    JournalService service = JournalService();
    bool result = await service.register(journal);

    return result;
  }
}