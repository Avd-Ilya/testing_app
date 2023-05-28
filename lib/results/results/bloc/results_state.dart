part of 'results_bloc.dart';

@immutable
abstract class ResultsState extends Equatable {
  final PassedTestDto passedTest;
  final int selectedQuestion;
  const ResultsState(this.passedTest, this.selectedQuestion);

  @override
  List<Object?> get props => [passedTest, selectedQuestion];
}

class ResultsInitial extends ResultsState {
  const ResultsInitial(super.passedTest, super.selectedQuestion);
}

class ResultsUpdated extends ResultsState {
  const ResultsUpdated(super.passedTest, super.selectedQuestion);
}

class ResultsShouldFinish extends ResultsState {
  const ResultsShouldFinish(super.passedTest, super.selectedQuestion);
}

class ResultsClose extends ResultsState {
  const ResultsClose(super.passedTest, super.selectedQuestion);
}