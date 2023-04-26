import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:core/web_client.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';
import 'package:fpdart/src/either.dart';
import 'package:testing_app/profile/service/profile_service.dart';

class ProfileServiceImpl implements ProfileService {
  @override
  Future<Either<FormatException, UserProfileDto?>> profile() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/user-info');
      var user = UserProfileDto.fromJson(json.decode(response));
      return Right(user);
    } catch (error) {
      return left(FormatException(error.toString()));
    }
  }
}