import 'package:flutter/material.dart';

import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../menu.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

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
          "about us",
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
      body: Container(
        padding: const EdgeInsets.all(2),
        alignment: AlignmentDirectional.topCenter,
        child: Text(
          'You can call me Rick.\n'
          'I\'m just trying my best to succeed.\n'
          'This is just the beginning.\n\n\n\n\n'
          'If you don\'t keep up...\nI\'ll be the one managing YOUR team.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,),
      ),
    );
  }
}
