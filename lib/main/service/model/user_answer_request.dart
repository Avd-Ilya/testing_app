import 'package:testing_app/main/service/model/selected_option_request.dart';

class UserAnswerRequest {
    UserAnswerRequest({
        this.questionId,
        this.selectedOptionRequests,
    });

    int? questionId;
    List<SelectedOptionRequest>? selectedOptionRequests;

    factory UserAnswerRequest.fromJson(Map<String, dynamic> json) => UserAnswerRequest(
        questionId: json["questionId"],
        selectedOptionRequests: json["selectedOptionRequests"] == null ? [] : List<SelectedOptionRequest>.from(json["selectedOptionRequests"]!.map((x) => SelectedOptionRequest.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "selectedOptionRequests": selectedOptionRequests == null ? [] : List<dynamic>.from(selectedOptionRequests!.map((x) => x.toJson())),
    };
}