import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import '../env.dart';

class JournalService {
  static const String url = Env.url; // i wish one of the .env packages worked
  static const String resource = '/diary/entry';

  http.Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()]
  );

  Future<Journal> get(String hash) async {
    http.Response response = await client.get(Uri.http(url, '$resource/$hash'));
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
    String hash = journal.hash;
    String jsonJournal = journal.toJson();
    http.Response response = await client.patch(
        Uri.http(url, '$resource/update', {'hash': hash}),
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

  Future<bool> delete(String hash) async {
    http.Response response = await client.delete(
      Uri.http(url, '$resource/delete', {'hash': hash}),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}