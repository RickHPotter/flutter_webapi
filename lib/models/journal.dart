import 'dart:convert';
import 'package:uuid/uuid.dart';

class Journal {
  String id;
  String hash;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Journal({
    required this.id,
    required this.hash,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Journal.fromMap(Map<String, dynamic> mapJournal)
    : id = '0', // so far, only fromMap used is retrieving from API
      hash = mapJournal["hash"],
      title = mapJournal["title"],
      content = mapJournal["content"],
      createdAt = DateTime.parse(mapJournal["createdAt"]),
      updatedAt = DateTime.parse(mapJournal["updatedAt"]);

  Journal.empty()
    : id = '0', // so far, only empty used is retrieving from API
      hash = const Uuid().v1(),
      title = "",
      content = "",
      createdAt = DateTime.now(),
      updatedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "hash": hash,
      "title": title,
      "content": content,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  static Journal toJournal(String strJson) {
    Map<String, dynamic> mapJournal = jsonDecode(strJson);
    Journal journal = Journal.fromMap(mapJournal);
    return journal;
  }

  static List<Journal> toListOfJournals(String strJson) {
    List<dynamic> listMapJournals = jsonDecode(strJson);
    List<Journal> listJournals = [];

    for (var item in listMapJournals) {
      Journal journal = Journal.fromMap(item);
      listJournals.add(journal);
    }

    return listJournals;
  }

  @override
  String toString() {
    return "$title \n$content \ncreated_at: $createdAt\nupdated_at:$updatedAt";
  }
}
