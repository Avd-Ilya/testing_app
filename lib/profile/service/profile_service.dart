import 'package:fpdart/fpdart.dart';
import 'package:testing_app/profile/service/model/activity_tracked_test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_dto.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';

abstract class ProfileService {
  Future<Either<FormatException, UserProfileDto?>> profile();
  Future<Either<FormatException, List<TrackedTestDto>?>> getTrackedTests();
  Future<Either<FormatException, List<ActivityTrackedTestDto>?>> getActivityTrackedTest(int id);
}