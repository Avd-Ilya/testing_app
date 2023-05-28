part of 'test_bloc.dart';

@immutable
abstract class TestState extends Equatable {
  TestDto test;
  int selectedQuestion;
  List<List<int?>> selectedAnswerOptions;
  List<List<int?>> coparsionAnswerOptions;
  TestState(this.test, this.selectedQuestion, this.selectedAnswerOptions, this.coparsionAnswerOptions);

  @override
  List<Object?> get props => [test, selectedQuestion, selectedAnswerOptions.iterator, coparsionAnswerOptions.iterator];
}

class TestInitial extends TestState {
  TestInitial(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions);
}

class TestUpdated extends TestState {
  TestUpdated(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions);
}

class TestShouldFinish extends TestState {
  TestShouldFinish(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions);
}

class TestError extends TestState {
  final String message;
  TestError(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions, this.message);

  @override
  List<Object?> get props => [message];
}

class TestLoading extends TestState {
  TestLoading(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions);
}

class TestCompleted extends TestState {
  double result;
  TestCompleted(super.test, super.selectedQuestion, super.selectedAnswerOptions, super.coparsionAnswerOptions, this.result);

  @override
  List<Object?> get props => [result];
}
