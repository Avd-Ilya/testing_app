import 'dart:convert';
import 'package:core/config.dart';
import 'package:core/shared.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WebClient {
  String baseUrl = Config().baseUrl;
  var token = Shared().getToken();

  Future<String> getToken() async {
    var token = await Shared().getToken();
    return token ?? '';
  }

  Future<Map<String, String>> defaultHeaders() async {
    var token = await Shared().getToken();
    if (token != null) {
      debugPrint(token.toString());
      return {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer $token" 
      };
    } else {
      return {"Accept": "application/json", "content-type": "application/json"};
    }
  }

  WebClient();
  WebClient.withBaseUrl(this.baseUrl);

  Future<dynamic> get(String path, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse('$baseUrl$path'),
        headers: headers ?? await defaultHeaders());
    return _handleResponse(response);
  }

  Future<dynamic> post(String path,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(Uri.parse('$baseUrl$path'),
        headers: headers ?? await defaultHeaders(), body: json.encode(body));
    return _handleResponse(response);
  }

  Future<dynamic> put(String path,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(Uri.parse('$baseUrl$path'),
        headers: headers ?? await defaultHeaders(), body: json.encode(body));
    return _handleResponse(response);
  }

  Future<dynamic> delete(String path, {Map<String, String>? headers}) async {
    final response = await http.delete(Uri.parse('$baseUrl$path'),
        headers: headers ?? await defaultHeaders());
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) async {
    // final responseBody = json.decode(response.body);
    debugPrint('');
    debugPrint('----------------');
    debugPrint(response.request.toString());
    debugPrint('${await defaultHeaders()}');
    debugPrint(response.reasonPhrase.toString() + ' ${response.statusCode}');
    debugPrint(response.body.toString());
    debugPrint('----------------');
    debugPrint('');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      // throw Exception(responseBody['message']);
      throw Exception('Error');
    }
  }
}
