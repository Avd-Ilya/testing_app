import 'dart:convert';

import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/service/model/question_dto.dart';

List<TestDto> testsDtoFromJson(String str) => List<TestDto>.from(json.decode(str).map((x) => TestDto.fromJson(x)));

String testDtoToJson(List<TestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestDto {
    TestDto({
        this.id,
        this.topic,
        this.chapterId,
        this.chapter,
        required this.questions,
    });

    int? id;
    String? topic;
    int? chapterId;
    ChapterDto? chapter;
    List<QuestionDto?> questions;

    factory TestDto.fromJson(Map<String, dynamic> json) => TestDto(
        id: json["id"],
        topic: json["topic"],
        chapterId: json["chapterId"],
        chapter: ChapterDto.fromJson(json["chapter"]),
        questions: List<QuestionDto>.from(json["questions"].map((x) => QuestionDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "chapterId": chapterId,
        "chapter": chapter?.toJson(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x?.toJson())),
    };
}