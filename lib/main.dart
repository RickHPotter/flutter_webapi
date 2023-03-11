import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/about_screen/about_screen.dart';
import 'package:flutter_webapi_first_course/screens/overview_screen/overview_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/edit_journal_screen.dart';
import 'package:flutter_webapi_first_course/theme/theme.dart';

import 'models/journal.dart';
import 'screens/home_screen/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      themeMode: ThemeMode.light,

      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
        "overview": (context) => const Overview(),
        "about": (context) => const About(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-journal") {
          final Journal journal = settings.arguments as Journal;
          return MaterialPageRoute(builder: (context) {
              return AddJournalScreen(journal: journal);
          }
          );
        }
        if (settings.name == "edit-journal") {
          final Journal journal = settings.arguments as Journal;
          return MaterialPageRoute(builder: (context) {
            return EditJournalScreen(journal: journal);
          }
          );
        }
        return null;
      },
    );
  }
}
