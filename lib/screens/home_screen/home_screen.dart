import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'package:flutter_webapi_first_course/screens/components/modal_alert.dart';
import 'package:flutter_webapi_first_course/services/auth_service.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/models/dao.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/screens/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();

  final ScrollController _listScrollController = ScrollController();
  Map<String, Journal> database = {};

  AuthService service = AuthService();

  // ----- Side Menu
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  bool isOpened = false;

  toggleMenu() {
    final state = sideMenuKey.currentState!;
    if (state.isOpened) {
      state.closeSideMenu();
    } else {
      state.openSideMenu();
    }
  }
  // Side Menu -----

  @override
  void initState() {
    super.initState();
    refreshFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: sideMenuKey,
        inverse: false,
        background: Theme.of(context).colorScheme.primary,
        type: SideMenuType.slide,
        menu: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: BuildMenu(),
        ),
        onChange: (didOpen) {
          setState(() => isOpened = didOpen);
        },
        child: IgnorePointer(ignoring: isOpened, child: scaffold()));
  }

  Widget scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //journal.createdAt.day.toString().padLeft(2, '0')
          "${today.day.toString().padLeft(2, '0')} | ${today.month} | ${today.year}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
          child: ElevatedButton(
              child: Icon(Icons.menu_open_rounded,
                  color: Theme.of(context).colorScheme.background),
              onPressed: () {
                toggleMenu();
              }),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.api_outlined),
              onPressed: () {
                retrieveFromApi();
              }),
          IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        controller: _listScrollController,
        children: generateListJournalCards(
          currentDay: today,
          database: database,
          refreshFunction: refreshFromDB,
        ),
      ),
    );
  }

  void retrieveFromApi() async {
    JournalService journalService = JournalService();
    await journalService
        .ping() // test if there's connection and API is up
        .then((value) async {
      await Dao.retrieveFromAPI();
      refreshFromDB();
      if (context.mounted) {
        quickAlertInfo(context, "___________",
            title: "Success.",
            confirmBtnColor: Theme.of(context).colorScheme.primary);
      }
    }).catchError((error) {
      quickAlertError(context, error.toString().split("Exception:")[1]);
    });
  }

  void refreshFromDB() async {
    database = await Dao.refreshFromDB().whenComplete(() => setState(() {}));
  }

  void logOut(BuildContext context) {
    quickAlertConfirm(context, "Are you sure you want to logout?", () {
      service.logout;
      Navigator.pushNamed(context, "login");
    });
  }
}
