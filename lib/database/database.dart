import 'dart:math';

import 'package:flutter_webapi_first_course/helpers/phrases.dart';
import 'package:uuid/uuid.dart';

import '../models/journal.dart';

Map<String, Journal> generateRandomDatabase({
  required int maxGap, // Max size of time windows
  required int amount, // Generated entries
}) {
  Random rng = Random();

  Map<String, Journal> map = {};

  for (int i = 0; i < amount; i++) {
    int timeGap = rng.nextInt(maxGap - 1); // Defines a distance from today
    DateTime date = DateTime.now().subtract(
      Duration(days: timeGap),
    );

    String id = const Uuid().v1();

    map[id] = Journal(
      id: id,
      content: getRandomPhrase(),
      createdAt: date,
      updatedAt: date,
    );
  }
  return map;
}
