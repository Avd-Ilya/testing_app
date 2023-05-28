import 'dart:convert';

import 'package:testing_app/main/service/model/selected_option_request.dart';
import 'package:testing_app/main/service/model/user_answer_request.dart';

PassedTestRequestDto passedTestRequestDtoFromJson(String str) => PassedTestRequestDto.fromJson(json.decode(str));

String passedTestRequestDtoToJson(PassedTestRequestDto data) => json.encode(data.toJson());

class PassedTestRequestDto {
    PassedTestRequestDto({
        this.date,
        this.result,
        this.testId,
        this.trackedTestId,
        this.userAnswerRequests,
    });

    DateTime? date;
    int? result;
    int? testId;
    int? trackedTestId;
    List<UserAnswerRequest>? userAnswerRequests;

    factory PassedTestRequestDto.fromJson(Map<String, dynamic> json) => PassedTestRequestDto(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        result: json["result"],
        testId: json["testId"],
        trackedTestId: json["trackedTestId"],
        userAnswerRequests: json["userAnswerRequests"] == null ? [] : List<UserAnswerRequest>.from(json["userAnswerRequests"]!.map((x) => UserAnswerRequest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "result": result,
        "testId": testId,
        "trackedTestId": trackedTestId,
        "userAnswerRequests": userAnswerRequests == null ? [] : List<dynamic>.from(userAnswerRequests!.map((x) => x.toJson())),
    };
}
