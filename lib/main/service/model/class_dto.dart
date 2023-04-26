// To parse this JSON data, do
//
//     final classDto = classDtoFromJson(jsonString);

import 'dart:convert';

List<ClassDto> classesDtoFromJson(String str) => List<ClassDto>.from(json.decode(str).map((x) => ClassDto.fromJson(x)));

class ClassDto {
    ClassDto({
        required this.id,
        required this.name,
    });

    int? id;
    String? name;

    factory ClassDto.fromJson(Map<String, dynamic> json) => ClassDto(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
