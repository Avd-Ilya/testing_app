import 'package:fpdart/fpdart.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';

abstract class MainService {
  Future<Either<FormatException, List<ClassDto>?>> getClasses();
  Future<Either<FormatException, List<SubjectDto>?>> getSubjects();
  Future<Either<FormatException, List<ChapterDto>?>> getChapters();
  Future<Either<FormatException, List<TestDto>?>> getTests();
}