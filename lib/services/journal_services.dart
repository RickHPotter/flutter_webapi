import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import '../env.dart';
import '../models/journal.dart';

class JournalService {
  static const String url = Env.url; // i wish one of the .env packages worked
  static const String resource = '/diary/entry';

  http.Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()]);

  Future<Journal> get(String id) async {
    http.Response response = await client.get(Uri.http(url, '$resource/$id'));
    if (response.statusCode == 200) {
      final resp = Journal.toJournal(response.body);
      return resp;
    }
    return Journal.empty();
  }

  Future<List<Journal>> getAll() async {
    http.Response response = await client.get(Uri.http(url, resource));
    if (response.statusCode == 200) {
      final resp = Journal.toListOfJournals(response.body);
      return resp;
    }
    return [Journal.empty()];
  }

  Future<bool> post(Journal journal) async {
    String jsonJournal = journal.toJson();
    http.Response response = await client.post(
        Uri.http(url, '$resource/insert'),
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

  Future<bool> patch(Journal journal) async {
    String id = journal.id;
    String jsonJournal = journal.toJson();
    http.Response response = await client.patch(
        Uri.http(url, '$resource/update', {'id': id}),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonJournal
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> delete(String id) async {
    http.Response response = await client.delete(
      Uri.http(url, '$resource/delete', {'id': id}),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}