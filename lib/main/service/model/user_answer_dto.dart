import 'package:testing_app/main/service/model/question_dto.dart';
import 'package:testing_app/main/service/model/selected_option_dto.dart';

class UserAnswerDto {
    int? id;
    int? passedTestId;
    int? questionId;
    QuestionDto? question;
    List<SelectedOptionDto>? selectedOptions;

    UserAnswerDto({
        this.id,
        this.passedTestId,
        this.questionId,
        this.question,
        this.selectedOptions,
    });

    factory UserAnswerDto.fromJson(Map<String, dynamic> json) => UserAnswerDto(
        id: json["id"],
        passedTestId: json["passedTestId"],
        questionId: json["questionId"],
        question: json["question"] == null ? null : QuestionDto.fromJson(json["question"]),
        selectedOptions: json["selectedOptions"] == null ? [] : List<SelectedOptionDto>.from(json["selectedOptions"]!.map((x) => SelectedOptionDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "passedTestId": passedTestId,
        "questionId": questionId,
        "question": question?.toJson(),
        "selectedOptions": selectedOptions == null ? [] : List<dynamic>.from(selectedOptions!.map((x) => x.toJson())),
    };
}