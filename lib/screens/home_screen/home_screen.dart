import 'package:flutter/material.dart';
import 'package:flutter_webapi_first_course/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_webapi_first_course/services/journal_services.dart';

import 'package:quickalert/quickalert.dart';


import '../../models/dao.dart';
import '../../models/journal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDay = DateTime.now();

  final ScrollController _listScrollController = ScrollController();
  JournalService service = JournalService();

  Map<String, Journal> database = {};

  @override
  void initState() {
    super.initState();
    refreshFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
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
              icon: const Icon(Icons.api_outlined)
          ),
          IconButton(
              onPressed: () {
                refreshFromDB();
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  title: 'Success.',
                  text: '___________',
                  confirmBtnColor: Colors.black,
                );
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
          refreshFunction: refreshFromDB,
        ),
      ),
    );
  }

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
    Dao.findAll([0, 1, 2])
        .then((list) => database = { for (var e in list) e.id : e })
        .whenComplete(() => setState(() {})
    );
  }
}
