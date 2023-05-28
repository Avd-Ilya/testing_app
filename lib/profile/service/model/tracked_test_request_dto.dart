
// List<TrackedTestDto> trackedTestsDtoFromJson(String str) => List<TrackedTestDto>.from(json.decode(str).map((x) => TrackedTestDto.fromJson(x)));
// TrackedTestDto trackedTestDtoFromJson(String str) => TrackedTestDto.fromJson(json.decode(str));

// String trackedTestDtoToJson(List<TrackedTestDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrackedTestRequestDto {
    DateTime? dateCreation;
    String? description;
    int? testId;

    TrackedTestRequestDto({
        this.dateCreation,
        this.description,
        this.testId,
    });

    // factory TrackedTestRequestDto.fromJson(Map<String, dynamic> json) => TrackedTestRequestDto(
    //     id: json["id"],
    //     key: json["key"],
    //     dateCreation: json["dateCreation"] == null ? null : DateTime.parse(json["dateCreation"]),
    //     description: json["description"],
    //     testId: json["testId"],
    //     test: json["test"] == null ? null : TestDto.fromJson(json["test"]),
    //     userId: json["userId"],
    //     user: json["user"] == null ? null : UserProfileDto.fromJson(json["user"]),
    // );

    Map<String, dynamic> toJson() => {
        "dateCreation": dateCreation?.toIso8601String(),
        "description": description,
        "testId": testId,
    };
}