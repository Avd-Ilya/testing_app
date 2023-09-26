part of 'activity_tracked_tests_bloc.dart';

@immutable
abstract class ActivityTrackedTestsState extends Equatable {
  List<ActivityTrackedTestDto> activityTrackedTests = [];
  ActivityTrackedTestsState(this.activityTrackedTests);

  @override
  List<Object?> get props => [];
}

class ActivityTrackedTestsInitial extends ActivityTrackedTestsState {
  ActivityTrackedTestsInitial(super.activityTrackedTests);
}

class ActivityTrackedTestsLoading extends ActivityTrackedTestsState {
  ActivityTrackedTestsLoading(super.activityTrackedTests);
}

class ActivityTrackedTestsLoaded extends ActivityTrackedTestsState {
  ActivityTrackedTestsLoaded(super.activityTrackedTests);
}

class ActivityTrackedTestsError extends ActivityTrackedTestsState {
  final String message;
  ActivityTrackedTestsError(super.activityTrackedTests, this.message);

  @override
  List<Object?> get props => [message];
}

class ActivityTrackedTestsCopyKey extends ActivityTrackedTestsState {
  final String key;
  ActivityTrackedTestsCopyKey(super.activityTrackedTests, this.key);

  @override
  List<Object?> get props => [key];
}