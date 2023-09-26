import 'dart:convert';

import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';

List<ActivityTrackedTestDto> activityTrackedTestsDtoFromJson(String str) => List<ActivityTrackedTestDto>.from(json.decode(str).map((x) => ActivityTrackedTestDto.fromJson(x)));
ActivityTrackedTestDto activityTrackedTestDtoFromJson(String str) => ActivityTrackedTestDto.fromJson(json.decode(str));

String activityTrackedTestDtoToJson(ActivityTrackedTestDto data) => json.encode(data.toJson());
String activityTrackedTestsDtoToJson(List<ActivityTrackedTestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityTrackedTestDto {
    UserProfileDto? user;
    PassedTestDto? passedTest;

    ActivityTrackedTestDto({
        this.user,
        this.passedTest,
    });

    factory ActivityTrackedTestDto.fromJson(Map<String, dynamic> json) => ActivityTrackedTestDto(
        user: json["user"] == null ? null : UserProfileDto.fromJson(json["user"]),
        passedTest: json["passedTest"] == null ? null : PassedTestDto.fromJson(json["passedTest"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "passedTest": passedTest?.toJson(),
    };
}