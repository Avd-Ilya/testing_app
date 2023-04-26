import 'dart:convert';

import 'package:core/config.dart';
import 'package:flutter/material.dart';
import 'package:core/web_client.dart';
import 'package:fpdart/src/either.dart';
import 'package:testing_app/auth/service/auth_service.dart';
import 'package:http/http.dart' as http;

class AuthServiceImpl implements AuthService {
  @override
  Future<Either<FormatException, String?>> login(
      String email, String password) async {
    var webClient = WebClient();
    var body = {'username': email, 'password': password, 'fio': ''};

    try {
      var response = await webClient.post('/login', body: body);
      // debugPrint('response - ${response}');
      // debugPrint('response str - ${json.decode(response)}');
      return Right(response);
    } catch (e) {
      debugPrint('3');
      debugPrint('error - $e');
      return left(FormatException(e.toString()));
    }
  }

  @override
  Future<Either<FormatException, String?>> register(
      String email, String password, String fio) async {
    var webClient = WebClient();
    var body = {'username': email, 'password': password, 'fio': fio};

    try {
      var response = await webClient.post('/register', body: body);
      return Right(response);
    } catch (e) {
      debugPrint('3');
      debugPrint('error - $e');
      return left(FormatException(e.toString()));
    }
  }
}
