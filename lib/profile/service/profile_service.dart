import 'package:fpdart/fpdart.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';

abstract class ProfileService {
  Future<Either<FormatException, UserProfileDto?>> profile();
}