import 'dart:convert';

List<AnswerOptionDto> answerOptionDtoFromJson(String str) => List<AnswerOptionDto>.from(json.decode(str).map((x) => AnswerOptionDto.fromJson(x)));

class AnswerOptionDto {
    AnswerOptionDto({
        this.id,
        this.text,
        this.isCorrect,
        this.position,
        this.leftOptionId,
        this.questionId,
    });

    int? id;
    String? text;
    bool? isCorrect;
    int? position;
    int? leftOptionId;
    int? questionId;

    factory AnswerOptionDto.fromJson(Map<String, dynamic> json) => AnswerOptionDto(
        id: json["id"],
        text: json["text"],
        isCorrect: json["isCorrect"],
        position: json["position"],
        leftOptionId: json["leftOptionId"],
        questionId: json["questionId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "isCorrect": isCorrect,
        "position": position,
        "leftOptionId": leftOptionId,
        "questionId": questionId,
    };
}
