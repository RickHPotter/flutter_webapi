import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/services/auth_service.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'package:quickalert/quickalert.dart';

import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';
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
  JournalService service = JournalService();
  Map<String, Journal> database = {};

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
        child: IgnorePointer(
            ignoring: isOpened,
            child: scaffold()
        )
    );
  }

  Widget scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text( //journal.createdAt.day.toString().padLeft(2, '0')
          "${today.day.toString().padLeft(2, '0')} | ${today.month} | ${today.year}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
          child: ElevatedButton(
            child: Icon(
                Icons.menu_open_rounded,
                color: Theme.of(context).colorScheme.background
            ),
            onPressed: () {
              toggleMenu();
            }
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.api_outlined),
            onPressed: () {
              retrieveFromApi();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                title: 'Success.',
                text: '___________',
                confirmBtnColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              );
            }
          ),IconButton(
              onPressed: () {
                AuthService service = AuthService();
                service.logout();
                Navigator.pushNamed(context, "login");
              }
              ,
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

  // TODO :  SOME REFACTORING DOWN HERE, I SUPPOSE
  void retrieveFromApi() async {
    int countDB = 0;
    // firstly, all data from the DB goes to the API
    List<Journal> pendingDelete = await Dao.findAll([-1]);

    debugPrint("delete later");
    for (Journal journal in pendingDelete) {
      bool result = await service.delete(journal.hash);
      if (result) {
        await Dao.delete(journal.hash);
        countDB++;
      }
    }

    debugPrint("insert later");
    List<Journal> pendingInsert = await Dao.findAll([1]);
    for (Journal journal in pendingInsert) {
      bool result = await service.post(journal);
      if (result) {
        await Dao.update(journal);
        countDB++;
      }
    }

    debugPrint("updating later");
    List<Journal> pendingUpdate = await Dao.findAll([2]);
    for (Journal journal in pendingUpdate) {
      bool result = await service.patch(journal);
      if (result) {
        await Dao.update(journal);
        countDB++;
      }
    }

    // secondly, all data from API comes to the DB
    List<Journal> list = await service.getAll();
    if (list.isNotEmpty) {
      for (var e in list) {
        await Dao.insert(e);  // TODO: implement later a batch insert
      }
    }

    String ret = '$countDB changes updated and ${list.length} changes retrieved.';
    debugPrint('RETURN : $ret');

    refreshFromDB();
  }

  void refreshFromDB() async { // i really wish i knew why async makes a difference in a non-await function,
    Dao.findAll([0, 1, 2])
        .then((list) => database = { for (var e in list) e.hash : e })
        .whenComplete(() => setState(() {})
    );
  }
}
