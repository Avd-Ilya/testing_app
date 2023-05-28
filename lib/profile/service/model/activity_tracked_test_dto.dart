import 'dart:convert';

import 'package:testing_app/profile/service/model/user_profile_dto.dart';

List<ActivityTrackedTestDto> activityTrackedTestsDtoFromJson(String str) => List<ActivityTrackedTestDto>.from(json.decode(str).map((x) => ActivityTrackedTestDto.fromJson(x)));
ActivityTrackedTestDto activityTrackedTestDtoFromJson(String str) => ActivityTrackedTestDto.fromJson(json.decode(str));

String activityTrackedTestDtoToJson(ActivityTrackedTestDto data) => json.encode(data.toJson());
String activityTrackedTestsDtoToJson(List<ActivityTrackedTestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityTrackedTestDto {
    String? userId;
    UserProfileDto? user;
    DateTime? date;
    double? result;
    int? testId;
    int? trackedTestId;

    ActivityTrackedTestDto({
        this.userId,
        this.user,
        this.date,
        this.result,
        this.testId,
        this.trackedTestId,
    });

    factory ActivityTrackedTestDto.fromJson(Map<String, dynamic> json) => ActivityTrackedTestDto(
        userId: json["userId"],
        user: json["user"] == null ? null : UserProfileDto.fromJson(json["user"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        result: json["result"]?.toDouble(),
        testId: json["testId"],
        trackedTestId: json["trackedTestId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "user": user?.toJson(),
        "date": date?.toIso8601String(),
        "result": result,
        "testId": testId,
        "trackedTestId": trackedTestId,
    };
}