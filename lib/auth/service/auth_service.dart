import 'package:fpdart/fpdart.dart';

abstract class AuthService {
  Future<Either<FormatException, String?>> login(String email, String password);
  Future<Either<FormatException, String?>> register(String email, String password, String fio);
}