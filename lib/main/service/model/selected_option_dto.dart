import 'package:testing_app/main/service/model/answer_option_dto.dart';

class SelectedOptionDto {
    int? id;
    dynamic position;
    int? answerOtionId;
    AnswerOptionDto? answerOtion;
    int? userAnswerId;

    SelectedOptionDto({
        this.id,
        this.position,
        this.answerOtionId,
        this.answerOtion,
        this.userAnswerId,
    });

    factory SelectedOptionDto.fromJson(Map<String, dynamic> json) => SelectedOptionDto(
        id: json["id"],
        position: json["position"],
        answerOtionId: json["answerOtionId"],
        answerOtion: json["answerOtion"] == null ? null : AnswerOptionDto.fromJson(json["answerOtion"]),
        userAnswerId: json["userAnswerId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "answerOtionId": answerOtionId,
        "answerOtion": answerOtion?.toJson(),
        "userAnswerId": userAnswerId,
    };
}