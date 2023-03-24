import 'package:http_interceptor/http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../env.dart';

class AuthService {
  static const url = Env.url;
  http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  Future<bool> login({required String email, required String password}) async {
    http.Response response = await client.post(
      Uri.http(url, "/login"),
      headers: { 'Content-Type': 'application/json' },
      body: json.encode({"email": email, "password": password}),
    );
    if (response.statusCode != 202) {
      throw HttpException("Error: ${response.body}");
    }
    saveUserInfo(response.body);
    return true;
  }

  Future<bool> signup({required String email, required String password}) async {
    http.Response response = await client.post(
      Uri.http(url, "/signup"),
      headers: { 'Content-Type': 'application/json' },
      body: json.encode({"email": email, "password": password}),
    );
    if (response.statusCode != 202) {
      throw HttpException("Error: ${response.body}");
    }
    return true;
  }

  saveUserInfo(String response) async {
    Map<String, dynamic> jSON = json.decode(response);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("token", jSON["Token"]);
    preferences.setString("email", jSON["User"]["Email"]);
    preferences.setInt("id", jSON["User"]["ID"]);
  }

  logout () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    preferences.remove("email");
    preferences.remove("id");
  }
}