import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/models/dao.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/slidable_plugin.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';

import '../../../services/journal_services.dart';

class JournalCard extends StatelessWidget {
  final DateTime showedDate;
  final Function refreshFunction;
  final Journal? journal;

  const JournalCard(
      {
        Key? key,
        required this.showedDate,
        required this.refreshFunction,
        this.journal
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Sliding(
          editFunc: callEditJournalScreen,
          deleteFunc: callDelete,
          cntxt: context,
          id: journal!.id,
          content: InkWell(
            onLongPress: () {
              callAddJournalScreen(context);
            },
            onTap: () {
              callEditJournalScreen(context);
            },
            child: Container(
              height: 85,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 53,
                        width: 75,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          border: Border(
                              right: BorderSide(color: Colors.black87),
                              bottom: BorderSide(color: Colors.black87)
                          ),
                        ),
                        child: Text(
                          journal!.createdAt.day.toString(),
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 75,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black87),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(WeekDay(journal!.createdAt.weekday).short),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        journal!.id,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            callAddJournalScreen(context);
          },
          child: Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "${WeekDay(showedDate.weekday).short} - ${showedDate.day}",
              style: TextStyle(
                color: WeekDay(showedDate.weekday).colour
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  callAddJournalScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      "add-journal",
      arguments: Journal(
        id: const Uuid().v1(),
        content: "",
        createdAt: showedDate,
        updatedAt: showedDate,
      ),
    ).then((value) {
      if (value != null && value == true) {
        if(context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Saving...')
            ),
          );
        }
      }
      refreshFunction();
    });
  }

  callEditJournalScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      "edit-journal",
      arguments: journal
    ).then((value) {
      if (value != null && value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Updating...')
          ),
        );
      }
      refreshFunction();
    });
  }

  callDelete(BuildContext context) async {
    await Dao.delete(journal!.id);
    // await Dao.prepareForDelete(journal!);
    refreshFunction();
    return true;
  }

}

