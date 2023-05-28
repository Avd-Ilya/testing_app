part of 'tracked_tests_list_bloc.dart';

@immutable
abstract class TrackedTestsListEvent extends Equatable {
  const TrackedTestsListEvent();

  @override
  List<Object?> get props => [];
}


class TrackedTestsListOnAppear extends TrackedTestsListEvent {}

class TrackedTestsListSelected extends TrackedTestsListEvent {
  final int index;
  const TrackedTestsListSelected(this.index);

  @override
  List<Object?> get props => [index];
}