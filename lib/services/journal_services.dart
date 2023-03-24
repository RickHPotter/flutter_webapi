import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

import 'package:flutter_webapi_first_course/models/journal.dart';
import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../env.dart';

class JournalService {
  static const String url = Env.url; // i wish one of the .env packages worked
  static const String resource = '/api/v1/diary';

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? cookieAuth = preferences.getString("token");

    if (cookieAuth == null) {
      return "";
    }

    return cookieAuth;
  }

  Future<Map<String, String>> defaultHeaders() async {
    String cookieAuth = await getToken();
    Map<String, String> headers =
    {
      'Content-Type': 'application/json',
      'Cookie': 'Authorisation=$cookieAuth',
    };
    return headers;
  }

  http.Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()]
  );

  Future<Journal> get(String hash) async {  // unused so far, beware of empty journal return
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client.get(
        Uri.http(url, '$resource/$hash'),
        headers: defHeaders,
    );
    if (response.statusCode == 200) {
      final resp = Journal.toJournal(response.body);
      return resp;
    }
    return Journal.empty(); // in case this is ever needed, add a userId param to empty()
  }

  Future<List<Journal>> getAll() async {
    String cookieAuth = await getToken();
    http.Response response = await client.get(
        Uri.http(url, resource),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorisation=$cookieAuth',
      }
    );
    if (response.statusCode == 200) {
      final resp = Journal.toListOfJournals(response.body);
      return resp;
    }
    return [];
  }

  Future<bool> post(Journal journal) async {
    Map<String, String> defHeaders = await defaultHeaders();
    String jsonJournal = await journal.toJson();
    http.Response response = await client.post(
        Uri.http(url, '$resource/insert'),
        headers: defHeaders,
        body: jsonJournal
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> patch(Journal journal) async {
    Map<String, String> defHeaders = await defaultHeaders();
    String hash = journal.hash;
    String jsonJournal = await journal.toJson();
    http.Response response = await client.patch(
        Uri.http(url, '$resource/update', {'hash': hash}),
        headers: defHeaders,
        body: jsonJournal
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> delete(String hash) async {
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client.delete(
      Uri.http(url, '$resource/delete', {'hash': hash}),
      headers: defHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}