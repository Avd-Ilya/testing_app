import 'dart:convert';

import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';

List<TrackedTestDto> trackedTestsDtoFromJson(String str) => List<TrackedTestDto>.from(json.decode(str).map((x) => TrackedTestDto.fromJson(x)));
TrackedTestDto trackedTestDtoFromJson(String str) => TrackedTestDto.fromJson(json.decode(str));

String trackedTestDtoToJson(List<TrackedTestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrackedTestDto {
    int? id;
    String? key;
    DateTime? dateCreation;
    String? description;
    int? testId;
    TestDto? test;
    String? userId;
    UserProfileDto? user;

    TrackedTestDto({
        this.id,
        this.key,
        this.dateCreation,
        this.description,
        this.testId,
        this.test,
        this.userId,
        this.user,
    });

    factory TrackedTestDto.fromJson(Map<String, dynamic> json) => TrackedTestDto(
        id: json["id"],
        key: json["key"],
        dateCreation: json["dateCreation"] == null ? null : DateTime.parse(json["dateCreation"]),
        description: json["description"],
        testId: json["testId"],
        test: json["test"] == null ? null : TestDto.fromJson(json["test"]),
        userId: json["userId"],
        user: json["user"] == null ? null : UserProfileDto.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "dateCreation": dateCreation?.toIso8601String(),
        "description": description,
        "testId": testId,
        "test": test?.toJson(),
        "userId": userId,
        "user": user,
    };
}