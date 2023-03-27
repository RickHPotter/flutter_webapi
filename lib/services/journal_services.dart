import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:flutter_webapi_first_course/services/web_client.dart';
import 'package:flutter_webapi_first_course/models/journal.dart';

class JournalService {
  String url = WebService.url;
  http.Client client = WebService.start(timeOut: 5);
  static const String resource = '/api/v1/diary';

  static const String noInternet = "Can't connect. You probably have no juice.";
  static const String apiDown = "Can't connect. Our Servers are probably down.";
  static const String expiredJWT = "Login Session Expired. Please logout and login again.";

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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authorisation=$cookieAuth',
    };
    return headers;
  }

  Future<Journal> get(String hash) async {
    // unused so far, beware of empty journal return
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client
        .get(
          Uri.http(url, '$resource/$hash'),
          headers: defHeaders,
        )
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.body}");
    }

    final resp = Journal.toJournal(response.body);
    return resp;
  }

  Future<List<Journal>> getAll() async {
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client
        .get(
          Uri.http(url, resource),
          headers: defHeaders,
        )
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.body}");
    }

    final resp = Journal.toListOfJournals(response.body);
    return resp;
  }

  Future<bool> post(Journal journal) async {
    Map<String, String> defHeaders = await defaultHeaders();
    String jsonJournal = await journal.toJson();
    http.Response response = await client
        .post(Uri.http(url, '$resource/insert'),
            headers: defHeaders, body: jsonJournal)
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    if (response.statusCode != 201) {
      throw HttpException("Error: ${response.body}");
    }
    return true;
  }

  Future<bool> patch(Journal journal) async {
    Map<String, String> defHeaders = await defaultHeaders();
    String hash = journal.hash;
    String jsonJournal = await journal.toJson();
    http.Response response = await client
        .patch(Uri.http(url, '$resource/update', {'hash': hash}),
            headers: defHeaders, body: jsonJournal)
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.body}");
    }
    return true;
  }

  Future<bool> delete(String hash) async {
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client
        .delete(
          Uri.http(url, '$resource/delete', {'hash': hash}),
          headers: defHeaders,
        )
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    if (response.statusCode != 200) {
      throw HttpException("Error: ${response.body}");
    }
    return true;
  }

  Future<bool> ping() async {
    Map<String, String> defHeaders = await defaultHeaders();
    http.Response response = await client
        .get(Uri.http(url, "/ping"), headers: defHeaders)
        .catchError((error) => throw TimeoutException(apiDown),
            test: (error) => error is TimeoutException)
        .catchError((error) => throw const SocketException(noInternet),
            test: (error) => error is SocketException);

    switch (response.statusCode) {
      case 202:
        return true;
      default:
        String errorContent = json.decode(response.body)["Error"];
        throw HttpException(errorContent);
    }
  }
}
