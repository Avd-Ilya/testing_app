class SelectedOptionRequest {
    SelectedOptionRequest({
        this.position,
        this.answerOptionId,
    });

    int? position;
    int? answerOptionId;

    factory SelectedOptionRequest.fromJson(Map<String, dynamic> json) => SelectedOptionRequest(
        position: json["position"],
        answerOptionId: json["answerOptionId"],
    );

    Map<String, dynamic> toJson() => {
        "position": position,
        "answerOptionId": answerOptionId,
    };
}