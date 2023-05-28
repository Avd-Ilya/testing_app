import 'package:testing_app/auth/service/auth_service.dart';
import 'package:fpdart/src/either.dart';

class MockAuthService implements AuthService {
  late Either<FormatException, String?> getLoginResults;
  late Either<FormatException, String?> getRegisterResults;

  @override
  Future<Either<FormatException, String?>> login(
      String email, String password) async {
    return getLoginResults;
  }

  void getLoginResultsSuccess() {
    getLoginResults = const Right('Success');
  }

  void getLoginResultsFailure() {
    getLoginResults = const Left(FormatException());
  }

  @override
  Future<Either<FormatException, String?>> register(
      String email, String password, String fio) async {
    return getRegisterResults;
  }

  void getRegisterResultsSuccess() {
    getRegisterResults = const Right('Success');
  }

  void getRegisterResultsFailure() {
    getRegisterResults = const Left(FormatException());
  }
}
