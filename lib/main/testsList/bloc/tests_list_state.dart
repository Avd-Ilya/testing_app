part of 'tests_list_bloc.dart';

@immutable
abstract class TestsListState extends Equatable {
  const TestsListState();

  @override
  List<Object?> get props => [];
}

class TestsListInitial extends TestsListState {}

class TestsListLoading extends TestsListState {}

class TestsListLoaded extends TestsListState {
  final List<TestDto> tests;
  const TestsListLoaded(this.tests);

  @override
  List<Object?> get props => [tests];
}

class TestsListError extends TestsListState {
  final String message;
  const TestsListError(this.message);

  @override
  List<Object?> get props => [message];
}

class TestsListShowTest extends TestsListState {
  final TestDto test;
  const TestsListShowTest(this.test);

  @override
  List<Object?> get props => [test];
}