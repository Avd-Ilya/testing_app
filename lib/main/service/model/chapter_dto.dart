import 'dart:convert';

import 'package:testing_app/main/service/model/subject_dto.dart';

List<ChapterDto> chaptersDtoFromJson(String str) => List<ChapterDto>.from(json.decode(str).map((x) => ChapterDto.fromJson(x)));

class ChapterDto {
    ChapterDto({
        this.id,
        this.name,
        this.subjectId,
        this.subject,
    });

    int? id;
    String? name;
    int? subjectId;
    SubjectDto? subject;

    factory ChapterDto.fromJson(Map<String, dynamic> json) => ChapterDto(
        id: json["id"],
        name: json["name"],
        subjectId: json["subjectId"],
        subject: SubjectDto.fromJson(json["subject"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subjectId": subjectId,
        "subject": subject?.toJson(),
    };
}