import 'package:core/web_client.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:fpdart/src/either.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/results/service/results_service.dart';

class ResultsServiceImpl implements ResultsService {
  @override
  Future<Either<FormatException, List<PassedTestDto>?>> getPassedTests() async {
    var webClient = WebClient();
    try {
      var response = await webClient.get('/passed-tests-by-user');
      var passedTests = passedTestsDtoFromJson(response);
      return Right(passedTests);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, TestDto?>> getTest(int id) async {
    var webClient = WebClient();
    try {
      var response = await webClient.get('/tests/{$id}', );
      var test = TestDto.fromJson(response);
      return Right(test);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }
}
