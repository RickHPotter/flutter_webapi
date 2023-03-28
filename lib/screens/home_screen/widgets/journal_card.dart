import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/components/colour_dot.dart';
import 'package:flutter_webapi_first_course/theme/theme_colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/models/dao.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/slidable_plugin.dart';
import 'package:flutter_webapi_first_course/theme/theme_typography.dart';
import 'package:flutter_webapi_first_course/helpers/weekday.dart';

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
          hash: journal!.hash,
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
                  color: WeekDay(journal!.createdAt.weekday).colour,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 53,
                        width: 75,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                              right: BorderSide(color: Theme.of(context).colorScheme.surface),
                              bottom: BorderSide(color: Theme.of(context).colorScheme.surface)
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColourDot(
                                colour: (journal!.id == '0')
                                    ? ThemeColours.colourDots['ballyhoo']
                                    : ThemeColours.colourDots['basketball']
                            ),
                            Text(
                              journal!.createdAt.day.toString().padLeft(2, '0'),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 75,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          WeekDay(journal!.createdAt.weekday).short,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        journal!.title,
                        style: Theme.of(context).textTheme.titleMedium,
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
              style: ThemeTypography.gFonts(
                  'Fira Code',
                  16, FontWeight.w400,
                  WeekDay(showedDate.weekday).colour
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  callAddJournalScreen(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getInt("id").toString();

    if (context.mounted) {
      Navigator.pushNamed(
        context,
        "add-journal",
        arguments: Journal(
          id: '1',
          // adding a journal is insert-mode, therefore 1, but this wont matter
          hash: "$userId.H.${const Uuid().v1()}",
          title: "",
          content: "",
          createdAt: showedDate,
          updatedAt: showedDate,
        ),
      ).then((value) {
        if (value != null && value == true) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text('...saving...', style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,)),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
        refreshFunction();
      });
    }
  }

  callEditJournalScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      "edit-journal",
      arguments: journal
    ).then((value) {
      if (value != null && value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('...updating...', style: Theme.of(context).textTheme.titleSmall,)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      refreshFunction();
    });
  }

  callDelete(BuildContext context) async {
    await Dao.prepareForDelete(journal!);
    refreshFunction();
    return true;
  }

}

