import 'package:fpdart/fpdart.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';

abstract class ResultsService {
   Future<Either<FormatException, List<PassedTestDto>?>> getPassedTests();
   Future<Either<FormatException, TestDto?>> getTest(int id);
}