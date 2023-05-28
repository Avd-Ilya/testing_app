import 'dart:ffi';

import 'package:fpdart/fpdart.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/main/service/model/passed_test_request_dto.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_request_dto.dart';

abstract class MainService {
  Future<Either<FormatException, List<ClassDto>?>> getClasses();
  Future<Either<FormatException, List<SubjectDto>?>> getSubjects(int classId);
  Future<Either<FormatException, List<ChapterDto>?>> getChapters(int subjectId);
  Future<Either<FormatException, List<TestDto>?>> getTests(int chapterId);
  Future<Either<FormatException, PassedTestDto?>> postPassedTest(PassedTestRequestDto passedTestRequest);
  Future<Either<FormatException, TrackedTestDto?>> createTrackedTest(TrackedTestRequestDto trackedTestRequestDto);
  Future<Either<FormatException, TrackedTestDto?>> getTrackedTest(String key);
  Future<Either<FormatException, TestDto?>> getTest(int id);
}