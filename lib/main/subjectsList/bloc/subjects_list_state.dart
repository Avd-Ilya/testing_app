part of 'subjects_list_bloc.dart';

@immutable
abstract class SubjectsListState extends Equatable {
  const SubjectsListState();

  @override
  List<Object?> get props => [];
}

class SubjectsListInitial extends SubjectsListState {}

class SubjectsListLoading extends SubjectsListState {}

class SubjectsListLoaded extends SubjectsListState {
  final List<SubjectDto> subjects;
  const SubjectsListLoaded(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class SubjectsListError extends SubjectsListState {
  final String message;
  const SubjectsListError(this.message);

  @override
  List<Object?> get props => [message];
}

class SubjectsListShowChapters extends SubjectsListState {
  final SubjectDto subject;
  const SubjectsListShowChapters(this.subject);

  @override
  List<Object?> get props => [subject];
}