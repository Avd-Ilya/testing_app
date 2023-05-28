part of 'results_list_bloc.dart';

@immutable
abstract class ResultsListState extends Equatable {
  final List<PassedTestDto> passedTests;
  const ResultsListState(this.passedTests);

  @override
  List<Object?> get props => [passedTests];
}

class ResultsListInitial extends ResultsListState {
  const ResultsListInitial(super.passedTests);
}

class ResultsListLoading extends ResultsListState {
  const ResultsListLoading(super.passedTests);
}

class ResultsListLoaded extends ResultsListState {
  const ResultsListLoaded(super.passedTests);
}

class ResultsListError extends ResultsListState {
  final String message;
  const ResultsListError(super.passedTests, this.message);

  @override
  List<Object?> get props => [message];
}

class ResultsListShowResults extends ResultsListState {
  final PassedTestDto passedTest;
  const ResultsListShowResults(super.passedTests, this.passedTest);

  @override
  List<Object?> get props => [passedTest];
}
