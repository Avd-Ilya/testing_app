part of 'classes_list_bloc.dart';

@immutable
abstract class ClassesListState extends Equatable {
  const ClassesListState();

  @override
  List<Object?> get props => [];
}

class ClassesListInitial extends ClassesListState {}

class ClassesListPopToRoot extends ClassesListState {}

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

class ClassesListShowAddTrackedTest extends ClassesListState {}

class ClassesListShowTrackedTest extends ClassesListState {
  final TestDto test;
  final int? trackedTestId;
  const ClassesListShowTrackedTest(this.test, this.trackedTestId);

  @override
  List<Object?> get props => [test, trackedTestId];
}