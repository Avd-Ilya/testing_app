part of 'activity_tracked_tests_bloc.dart';

@immutable
abstract class ActivityTrackedTestsState extends Equatable {
  final List<ActivityTrackedTestDto> activityTrackedTests;
  const ActivityTrackedTestsState(this.activityTrackedTests);

  @override
  List<Object?> get props => [];
}

class ActivityTrackedTestsInitial extends ActivityTrackedTestsState {
  const ActivityTrackedTestsInitial(super.activityTrackedTests);
}

class ActivityTrackedTestsLoading extends ActivityTrackedTestsState {
  const ActivityTrackedTestsLoading(super.activityTrackedTests);
}

class ActivityTrackedTestsLoaded extends ActivityTrackedTestsState {
  const ActivityTrackedTestsLoaded(super.activityTrackedTests);
}

class ActivityTrackedTestsError extends ActivityTrackedTestsState {
  final String message;
  const ActivityTrackedTestsError(super.activityTrackedTests, this.message);

  @override
  List<Object?> get props => [message];
}

class ActivityTrackedTestsCopyKey extends ActivityTrackedTestsState {
  final String key;
  const ActivityTrackedTestsCopyKey(super.activityTrackedTests, this.key);

  @override
  List<Object?> get props => [key];
}
class ActivityTrackedTestsShowResults extends ActivityTrackedTestsState {
  final PassedTestDto passedTest;
  const ActivityTrackedTestsShowResults(super.activityTrackedTests, this.passedTest);

  @override
  List<Object?> get props => [passedTest];
}