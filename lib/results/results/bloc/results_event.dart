part of 'results_bloc.dart';

@immutable
abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object?> get props => [];
}

class ResultsOnAppear extends ResultsEvent {}

class ResultsNextTapped extends ResultsEvent {}

class ResultsSelectedQuestion extends ResultsEvent {
  final int index;
  const ResultsSelectedQuestion(this.index);

  @override
  List<Object?> get props => [index];
}
class ResultsFinishAccepted extends ResultsEvent {}
