part of 'classes_list_bloc.dart';

@immutable
abstract class ClassesListState extends Equatable {
  const ClassesListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ClassesListInitial extends ClassesListState {}

class ClassesListLoading extends ClassesListState {}

class ClassesListLoaded extends ClassesListState {
  final List<ClassDto> classes;
  const ClassesListLoaded(this.classes);

  @override
  List<Object?> get props => [classes];
}

class ClassesListError extends ClassesListState {
  final String message;
  const ClassesListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ClassesListShowSubjects extends ClassesListState {
  final ClassDto schoolClass;
  const ClassesListShowSubjects(this.schoolClass);

  @override
  List<Object?> get props => [schoolClass];
}
