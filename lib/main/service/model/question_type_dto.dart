import 'dart:convert';

List<QuestionTypeDto> questionTypeDtoFromJson(String str) => List<QuestionTypeDto>.from(json.decode(str).map((x) => QuestionTypeDto.fromJson(x)));

class QuestionTypeDto {
    QuestionTypeDto({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory QuestionTypeDto.fromJson(Map<String, dynamic> json) => QuestionTypeDto(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}