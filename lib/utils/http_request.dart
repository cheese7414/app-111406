import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  static Future<dynamic> post(String url, String requestData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dynamic result;
    await http
        .post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            },
            body: requestData)
        .then((response) {
      var responseJson = response.headers.containsValue("application/json")
          ? json.decode(utf8.decode(response.bodyBytes))
          : response.body;
      result = responseJson;
      if (response.statusCode >= 400) {
        throw Exception(result["message"]);
      }
      if (response.headers['token'] != null) {
        prefs.setString('token', response.headers['token']!);
      }
    });
    return result;
  }

  static Future<dynamic> get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dynamic result;
    await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    ).then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode >= 400) {
        throw Exception(result["message"]);
      }
      if (response.headers['token'] != null) {
        prefs.setString('token', response.headers['token']!);
      }
    });
    return result;
  }

  static Future<dynamic> patch(String url, String? requestData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    dynamic result;
    await http
        .patch(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            },
            body: requestData)
        .then((response) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      result = responseJson;
      if (response.statusCode >= 400) {
        throw Exception(result["message"]);
      }
      if (response.headers['token'] != null) {
        prefs.setString('token', response.headers['token']!);
      }
    });
    return result;
  }
}

class HttpURL {
  // static const String host = "https://vaulted-epigram-349713.de.r.appspot.com";
  static const String host = "https://backend-111406.onrender.com/api";
  // static const String host = "https://backend-111406.herokuapp.com/api";

  /// 乙太幣相關api
  static const String ethHost = "http://140.131.114.165/eth";
}
