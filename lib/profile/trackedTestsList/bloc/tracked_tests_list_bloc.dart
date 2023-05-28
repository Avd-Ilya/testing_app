import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/profile/service/model/tracked_test_dto.dart';
import 'package:testing_app/profile/service/profile_service.dart';

part 'tracked_tests_list_event.dart';
part 'tracked_tests_list_state.dart';

class TrackedTestsListBloc extends Bloc<TrackedTestsListEvent, TrackedTestsListState> {
  final ProfileService profileService;
  List<TrackedTestDto> trackedTests = [];

  TrackedTestsListBloc(this.profileService) : super(TrackedTestsListInitial(const [])) {
    on<TrackedTestsListOnAppear>((event, emit) async {
      emit(TrackedTestsListLoading(trackedTests));
      var response = await profileService.getTrackedTests();
      response.fold((exception) {
        emit(TrackedTestsListError(trackedTests, exception.message));
      }, (value) {
        if(value != null) {
          trackedTests = value;
          emit(TrackedTestsListLoaded(trackedTests));
        }
      });
    });
    on<TrackedTestsListSelected>((event, emit) {
      emit(TrackedTestsListShowActivity(trackedTests, trackedTests[event.index].id ?? 0, trackedTests[event.index].key ?? ''));
    });
  }
}
