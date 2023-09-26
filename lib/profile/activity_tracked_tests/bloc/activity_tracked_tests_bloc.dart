import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/profile/service/model/activity_tracked_test_dto.dart';
import 'package:testing_app/profile/service/profile_service.dart';

part 'activity_tracked_tests_event.dart';
part 'activity_tracked_tests_state.dart';

class ActivityTrackedTestsBloc
    extends Bloc<ActivityTrackedTestsEvent, ActivityTrackedTestsState> {
  final ProfileService profileService;
  final int trackedTestId;
  final String tarckedTestKey;
  List<ActivityTrackedTestDto> activityTrackedTests = [];

  ActivityTrackedTestsBloc({required this.profileService, required this.trackedTestId, required this.tarckedTestKey})
      : super(const ActivityTrackedTestsInitial([])) {
    on<ActivityTrackedTestsOnAppear>((event, emit) async {
      emit(ActivityTrackedTestsLoading(activityTrackedTests));
      var response = await profileService.getActivityTrackedTest(trackedTestId);
      response.fold((exception) {
        emit(
            ActivityTrackedTestsError(activityTrackedTests, exception.message));
      }, (value) {
        if (value != null) {
          activityTrackedTests = value;
          emit(ActivityTrackedTestsLoaded(activityTrackedTests));
        }
      });
    });
    on<ActivityTrackedTestsCopyButtonTapped>((event, emit) {
      emit(ActivityTrackedTestsCopyKey(activityTrackedTests, tarckedTestKey));
    });
    on<ActivityTrackedTestsSelected>((event, emit) {
      emit(ActivityTrackedTestsShowResults(activityTrackedTests, activityTrackedTests[event.index].passedTest ?? PassedTestDto()));
    });
  }
}
