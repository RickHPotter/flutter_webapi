import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';

import 'package:quickalert/quickalert.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../models/dao.dart';
import '../../models/journal.dart';
import '../menu.dart';

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
        background: const Color.fromRGBO(0, 48, 73, 1),
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
        title: Text(
          "${today.day} | ${today.month} | ${today.year}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 0, 6),
          child: ElevatedButton(
            child: Icon(Icons.menu_open_rounded, color: Theme.of(context).colorScheme.secondary),
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
                confirmBtnColor: Colors.black,
              );
            },
          ),
          // IconButton(
          //     onPressed: () {
          //       refreshFromDB();
          //       QuickAlert.show(
          //         context: context,
          //         type: QuickAlertType.info,
          //         title: 'Success.',
          //         text: '___________',
          //         confirmBtnColor: Colors.black,
          //       );
          //     },
          //     icon: const Icon(Icons.refresh_sharp)
          // ),
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

    for (Journal journal in pendingDelete) {
      bool result = await service.delete(journal.id);
      if (result) {
        await Dao.delete(journal.id);
        countDB++;
      }
    }

    List<Journal> pendingInsert = await Dao.findAll([1]);
    for (Journal journal in pendingInsert) {
      bool result = await service.post(journal);
      if (result) {
        await Dao.update(journal);
        countDB++;
      }
    }

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
    for (var e in list) {
      await Dao.insert(e);  // implement later a batch insert
    }

    String ret = '$countDB changes updated and ${list.length} changes retrieved.';
    debugPrint('RETURN : $ret');

    refreshFromDB();
  }

  void refreshFromDB() async { // i really wish i knew why async makes a difference in a non-await function,
    Dao.findAll([-1, 0, 1, 2])
        .then((list) => database = { for (var e in list) e.id : e })
        .whenComplete(() => setState(() {})
    );
  }
}
