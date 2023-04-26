import 'dart:convert';
import 'package:flutter/material.dart';

UserProfileDto userProfileDtoFromJson(String str) =>
    UserProfileDto.fromJson(json.decode(str));

String userProfileDtoToJson(UserProfileDto data) => json.encode(data.toJson());

class UserProfileDto {
  UserProfileDto({
    required this.username,
    required this.fio,
  });

  String username;
  String fio;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return UserProfileDto(
      username: json["username"],
      fio: json["fio"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "fio": fio,
      };
}
