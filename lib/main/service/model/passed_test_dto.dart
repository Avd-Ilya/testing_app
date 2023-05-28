import 'dart:convert';
import 'dart:ffi';

import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/main/service/model/user_answer_dto.dart';

List<PassedTestDto> passedTestsDtoFromJson(String str) => List<PassedTestDto>.from(json.decode(str).map((x) => PassedTestDto.fromJson(x)));
PassedTestDto passedTestDtoFromJson(String str) => PassedTestDto.fromJson(json.decode(str));

String passedTestDtoToJson(List<PassedTestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PassedTestDto {
    int? id;
    DateTime? date;
    double? result;
    int? testId;
    TestDto? test;
    String? userId;
    List<UserAnswerDto>? userAnswers;

    PassedTestDto({
        this.id,
        this.date,
        this.result,
        this.testId,
        this.test,
        this.userId,
        this.userAnswers,
    });

    factory PassedTestDto.fromJson(Map<String, dynamic> json) => PassedTestDto(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        result: json["result"]?.toDouble(),
        testId: json["testId"],
        test: json["test"] == null ? null : TestDto.fromJson(json["test"]),
        userId: json["userId"],
        userAnswers: json["userAnswers"] == null ? [] : List<UserAnswerDto>.from(json["userAnswers"]!.map((x) => UserAnswerDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "result": result,
        "testId": testId,
        "test": test?.toJson(),
        "userId": userId,
        "userAnswers": userAnswers == null ? [] : List<dynamic>.from(userAnswers!.map((x) => x.toJson())),
    };
}