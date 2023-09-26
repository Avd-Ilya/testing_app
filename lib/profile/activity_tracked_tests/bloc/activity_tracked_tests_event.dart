part of 'activity_tracked_tests_bloc.dart';

@immutable
abstract class ActivityTrackedTestsEvent extends Equatable {
  const ActivityTrackedTestsEvent();

  @override
  List<Object?> get props => [];
}

class ActivityTrackedTestsOnAppear extends ActivityTrackedTestsEvent {}

class ActivityTrackedTestsCopyButtonTapped extends ActivityTrackedTestsEvent {}

class ActivityTrackedTestsSelected extends ActivityTrackedTestsEvent {
  final int index;
  const ActivityTrackedTestsSelected(this.index);

  @override
  List<Object?> get props => [index];
}