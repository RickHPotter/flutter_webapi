import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';

import '../models/journal.dart';

class JournalService {
  static const String url = '192.168.100.66:9090';
  static const String resource = 'diary/entry';

  http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  Future<String> get() async {
    http.Response response = await client.get(Uri.http(url, resource));
    if (response.statusCode == 200) {
      return response.body;
    }
    return Future.value('fuck');
  }

  Future<bool> register(Journal journal) async {
    String jsonJournal = json.encode(journal.toMap());
    http.Response response = await client.post(
        Uri.http(url, resource),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonJournal
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}