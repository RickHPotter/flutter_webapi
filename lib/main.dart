import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/about_screen/about_screen.dart';
import 'package:flutter_webapi_first_course/screens/login_screen/login_screen.dart';
import 'package:flutter_webapi_first_course/screens/overview_screen/overview_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/add_journal_screen.dart';
import 'package:flutter_webapi_first_course/screens/journal_screen/edit_journal_screen.dart';
import 'package:flutter_webapi_first_course/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/journal.dart';
import 'screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(isLogged: await verifyToken()));
}

Future<bool> verifyToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("token") != null) {
    // TODO: this is just not enough, gotta make sure that the Token is valid
     return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({Key? key, required this.isLogged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      themeMode: ThemeMode.dark,

      initialRoute: (isLogged) ? "home" : "login",
      routes: {
        "login": (context) => const LoginScreen(),
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
