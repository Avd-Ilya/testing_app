part of 'test_bloc.dart';

@immutable
abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object?> get props => [];
}

class TestOnAppear extends TestEvent {}

class TestSelectedQuestion extends TestEvent {
  final int index;
  const TestSelectedQuestion(this.index);

  @override
  List<Object?> get props => [index];
}

class TestSelectedAnswerOption extends TestEvent {
  final int index;
  int? id;
  TestSelectedAnswerOption(this.index);
  TestSelectedAnswerOption.withId(this.index, this.id);

  @override
  List<Object?> get props => [index];
}

class TestNextTapped extends TestEvent {}
