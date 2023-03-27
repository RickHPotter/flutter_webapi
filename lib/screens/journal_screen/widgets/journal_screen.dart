import 'package:flutter/material.dart';

import '../../../helpers/weekday.dart';
import '../../../models/journal.dart';
import '../../../theme/theme_typography.dart';

class JournalScreen extends StatelessWidget {
  final Journal journal;
  final BuildContext cntxt;
  final dynamic func;
  JournalScreen({Key? key, required this.journal, required this.cntxt, required this.func})
      : super(key: key);

  late final TextEditingController _titleController = TextEditingController(
    text: journal.title,
  );
  late final TextEditingController _contentController = TextEditingController(
    text: journal.content,
  );
  late final String appBarText =
      '${WeekDay(journal.createdAt.weekday).long}, '
      '${journal.createdAt.day.toString().padLeft(2, '0')}. ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await func(cntxt, _titleController.text , _contentController.text);
              if (context.mounted) {
                Navigator.pop(context, result);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: WeekDay(journal.createdAt.weekday).colour,
            height: 3,
          ),
          Flexible(
            child: TextField(
              controller: _titleController,
              keyboardType: TextInputType.name,
              style: ThemeTypography.gFonts('Rajdhani', 32, FontWeight.w400, WeekDay(journal.createdAt.weekday).colour),
              textAlign: TextAlign.center,
              minLines: 1,
              maxLines: 2,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 3,
          ),
          Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                scrollPadding: const EdgeInsets.only(top: 220),
                controller: _contentController,
                style: Theme.of(context).textTheme.titleMedium,
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLines: null,
                minLines: null,
              ),
            ),
          ),
      ],
      ),
    );
  }
}
