// import 'dart:convert';

// List<SubjectDto> subjectsDtoFromJson(String str) => List<SubjectDto>.from(json.decode(str).map((x) => SubjectDto.fromJson(x)));

// class SubjectDto {
//     SubjectDto({
//         required this.id,
//         required this.name,
//     });

//     int id;
//     String name;

//     factory SubjectDto.fromJson(Map<String, dynamic> json) => SubjectDto(
//         id: json["id"],
//         name: json["name"],
//     );
// }

import 'dart:convert';

import 'package:testing_app/main/service/model/class_dto.dart';

List<SubjectDto> subjectsDtoFromJson(String str) => List<SubjectDto>.from(json.decode(str).map((x) => SubjectDto.fromJson(x)));

class SubjectDto {
    SubjectDto({
        required this.id,
        required this.name,
        required this.schoolClassId,
        required this.schoolClass,
    });

    int? id;
    String? name;
    int? schoolClassId;
    ClassDto? schoolClass;

    factory SubjectDto.fromJson(Map<String, dynamic> json) => SubjectDto(
        id: json["id"],
        name: json["name"],
        schoolClassId: json["schoolClassId"],
        schoolClass: ClassDto.fromJson(json["schoolClass"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "schoolClassId": schoolClassId,
        "schoolClass": schoolClass?.toJson(),
    };
}