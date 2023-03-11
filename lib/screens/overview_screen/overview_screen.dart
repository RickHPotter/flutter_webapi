import 'package:flutter/material.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../menu.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
        key: sideMenuKey,
        inverse: false, // end side menu
        background: const Color.fromRGBO(0, 48, 73, 1),
        type: SideMenuType.shrinkNSlide,
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
        leading: IconButton(
            icon: const Icon(Icons.menu_open_rounded),
            onPressed: () {
              toggleMenu();
            }
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(2),
        child: const Text('OVERVIEW'),
      ),
    );
  }
}
