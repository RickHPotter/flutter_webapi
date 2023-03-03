import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';

import '../../models/journal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the last day is presented first
  DateTime currentDay = DateTime.now();

  // the database shown in the list
  Map<String, Journal> database = {};

  final ScrollController _listScrollController = ScrollController();

  JournalService service = JournalService();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  refresh();
                });
              },
              icon: const Icon(Icons.refresh_sharp)
          ),
        ],
      ),
      body: ListView(
        controller: _listScrollController,
        children: generateListJournalCards(
          currentDay: currentDay,
          database: database,
          refreshFunction: refresh,
        ),
      ),
    );
  }

  void refresh() async {
    List<Journal> all = await service.getAll();
    var mapJournal = { for (var e in all) e.id : e };
    setState(() {
      database = mapJournal;
    });
  }
}
