import 'package:flutter/material.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import '../../models/dao.dart';
import '../../models/journal.dart';
import '../menu.dart';

import 'package:flutter_webapi_first_course/screens/overview_screen/widgets/overview_screen_list.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

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

  late final List<Journal> database;

  @override
  void initState() {
    super.initState();
    orderGet();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: sideMenuKey,
        inverse: false, // end side menu
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
        centerTitle: true,
        title: Text(
        "overview",
        style: Theme.of(context).textTheme.titleMedium,
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
      ),
      body: rows(),
    );
  }

  Widget rows() {
    return GridView.count(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisCount: 2,
      children: generateListJournalCardsView (
          database: database,
      ),
    );
  }

  void orderGet() async {
    database = await Dao.orderedGet();
    setState(() {

    });
  }
}
