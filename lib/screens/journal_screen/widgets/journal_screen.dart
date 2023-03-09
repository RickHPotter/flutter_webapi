import 'package:flutter/material.dart';

import '../../../helpers/month_name.dart';
import '../../../helpers/weekday.dart';
import '../../../models/journal.dart';

class JournalScreen extends StatelessWidget {
  final Journal journal;
  final BuildContext cntxt;
  final dynamic func;
  JournalScreen({Key? key, required this.journal, required this.cntxt, required this.func})
      : super(key: key);

  late final TextEditingController _contentController = TextEditingController(
      text: journal.content
  );
  late final String appBarText =
      '${WeekDay(journal.createdAt.weekday).long}, '
      '${journal.createdAt.year} | '
      '${Month((journal.createdAt.month).toString()).long}, '
      '${journal.createdAt.day.toString().padLeft(2, '0')}. ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await func(cntxt, _contentController.text);
              if (context.mounted) { // i could also use .then((value) {nav.pop(context, value)} instead of async-await-pop
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
}
