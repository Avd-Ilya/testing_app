part of 'results_list_bloc.dart';

@immutable
abstract class ResultsListEvent extends Equatable {
  const ResultsListEvent();

  @override
  List<Object?> get props => [];
}

class ResultsListOnAppear extends ResultsListEvent {}

class ResultsListSelected extends ResultsListEvent {
  final int index;
  const ResultsListSelected(this.index);

  @override
  List<Object?> get props => [index];
}
