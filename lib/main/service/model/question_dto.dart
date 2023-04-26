import 'dart:convert';

import 'package:testing_app/main/service/model/answer_option_dto.dart';
import 'package:testing_app/main/service/model/question_type_dto.dart';

List<QuestionDto> questionDtoFromJson(String str) => List<QuestionDto>.from(json.decode(str).map((x) => QuestionDto.fromJson(x)));


class QuestionDto {
    QuestionDto({
        this.id,
        this.task,
        this.testId,
        this.questionTypeId,
        this.questionType,
        this.answerOptions,
    });

    int? id;
    String? task;
    int? testId;
    int? questionTypeId;
    QuestionTypeDto? questionType;
    List<AnswerOptionDto>? answerOptions;

    factory QuestionDto.fromJson(Map<String, dynamic> json) => QuestionDto(
        id: json["id"],
        task: json["task"],
        testId: json["testId"],
        questionTypeId: json["questionTypeId"],
        questionType: json["questionType"] == null ? null : QuestionTypeDto.fromJson(json["questionType"]),
        answerOptions: json["answerOptions"] == null ? [] : List<AnswerOptionDto>.from(json["answerOptions"]!.map((x) => AnswerOptionDto.fromJson(x))),
    );
    
    Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "testId": testId,
        "questionTypeId": questionTypeId,
        "questionType": questionType?.toJson(),
        "answerOptions": answerOptions == null ? [] : List<dynamic>.from(answerOptions!.map((x) => x.toJson())),
    };
}