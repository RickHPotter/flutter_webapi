import 'package:flutter/material.dart';

import '../../../helpers/month_name.dart';
import '../../../helpers/weekday.dart';
import '../../../models/journal.dart';

class JournalScreen extends StatelessWidget {
  final Journal journal;
  final BuildContext cont;
  final dynamic httpMethod;
  JournalScreen({Key? key, required this.journal, required this.cont, required this.httpMethod})
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
            onPressed: () {
              var result = sendHTTP();
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

  sendHTTP() async {
    return await httpMethod(cont, _contentController.text);
  }

}
