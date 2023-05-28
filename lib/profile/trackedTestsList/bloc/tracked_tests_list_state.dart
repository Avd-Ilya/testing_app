part of 'tracked_tests_list_bloc.dart';

@immutable
abstract class TrackedTestsListState extends Equatable {
  final List<TrackedTestDto> trackedTests;
  const TrackedTestsListState(this.trackedTests);

  @override
  List<Object?> get props => [trackedTests];
}

class TrackedTestsListInitial extends TrackedTestsListState {
  const TrackedTestsListInitial(super.trackedTests);
}

class TrackedTestsListLoading extends TrackedTestsListState {
   const TrackedTestsListLoading(super.trackedTests);
}

class TrackedTestsListLoaded extends TrackedTestsListState {
   const TrackedTestsListLoaded(super.trackedTests);
}

class TrackedTestsListError extends TrackedTestsListState {
  final String message;
  const TrackedTestsListError(super.trackedTests, this.message);

  @override
  List<Object?> get props => [super.props, message];
}

class TrackedTestsListShowActivity extends TrackedTestsListState {
  final int tarckedTestId;
  final String tarckedTestKey;
  const TrackedTestsListShowActivity(super.trackedTests, this.tarckedTestId, this.tarckedTestKey);

  @override
  List<Object?> get props => [super.props, trackedTests];
}
