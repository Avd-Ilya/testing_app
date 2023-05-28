part of 'tests_list_bloc.dart';

@immutable
abstract class TestsListEvent extends Equatable {
  const TestsListEvent();

  @override
  List<Object?> get props => [];
}

class TestsListNeedData extends TestsListEvent {}

class TestsListSelected extends TestsListEvent {
  final int index;
  const TestsListSelected(this.index);

  @override
  List<Object?> get props => [index];
}

class TestsListShouldCreateTrackedTest extends TestsListEvent {
  final int index;
  const TestsListShouldCreateTrackedTest(this.index);

  @override
  List<Object?> get props => [index];
}

class TestsListCreateTrackedTest extends TestsListEvent {
  final String text;
  const TestsListCreateTrackedTest(this.text);

  @override
  List<Object?> get props => [text];
}

class TestsListCreatingTrackedTestCancelled extends TestsListEvent {}
