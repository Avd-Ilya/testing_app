import 'package:core/web_client.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_request_dto.dart';
import 'package:fpdart/src/either.dart';

class MainServiceImpl implements MainService {
  @override
  Future<Either<FormatException, List<ClassDto>?>> getClasses() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/classes');
      var classes = classesDtoFromJson(response);
      return Right(classes);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, List<SubjectDto>?>> getSubjects(classId) async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/subjects/class/$classId');
      var subjects = subjectsDtoFromJson(response);
      return Right(subjects);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, List<ChapterDto>?>> getChapters(subjectId) async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/chapters/subject/$subjectId');
      var chapters = chaptersDtoFromJson(response);
      return Right(chapters);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, List<TestDto>?>> getTests(chapterId) async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/tests/chapter/$chapterId');
      var tests = testsDtoFromJson(response);
      return Right(tests);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, PassedTestDto?>> postPassedTest(
      passedTestRequest) async {
    var webClient = WebClient();

    try {
      var response = await webClient.post('/passed-tests-with-answers',
          body: passedTestRequest.toJson());
      var passedTest = passedTestDtoFromJson(response);
      return Right(passedTest);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, TrackedTestDto?>> createTrackedTest(
      TrackedTestRequestDto trackedTestRequestDto) async {
    var webClient = WebClient();

    try {
      var response = await webClient.post('/tracked-tests',
          body: trackedTestRequestDto.toJson());
      var trackedTest = trackedTestDtoFromJson(response);
      return Right(trackedTest);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }
  
  @override
  Future<Either<FormatException, TrackedTestDto?>> getTrackedTest(String key) async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/tracked-tests/key/$key');
      var trackedTest = trackedTestDtoFromJson(response);
      return Right(trackedTest);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }
  
  @override
  Future<Either<FormatException, TestDto?>> getTest(int id) async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/tests/$id');
      var test = testDtoFromJson(response);
      return Right(test);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }
}
