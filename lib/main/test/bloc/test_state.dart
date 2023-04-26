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

