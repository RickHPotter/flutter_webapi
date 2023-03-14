import 'package:flutter/material.dart';

import '../../../models/journal.dart';

class JournalCardView extends StatelessWidget {
  final Journal journal;
  const JournalCardView({Key? key, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 22, 8, 22),
      shadowColor: Colors.black,
      elevation: 22,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), topLeft: Radius.circular(5), topRight: Radius.circular(5))
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(2, 8, 2, 12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
                  color: Colors.black54,
                ),
                child: Text(
                  journal.createdAt.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
              child: Text(
                  journal.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
