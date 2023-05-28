part of 'classes_list_bloc.dart';

@immutable
abstract class ClassesListEvent extends Equatable {
  const ClassesListEvent();

  @override
  List<Object?> get props => [];
}

class ClassesListOnAppear extends ClassesListEvent {}

class ClassesListTabSelected extends ClassesListEvent {}

class ClassesListSelected extends ClassesListEvent {
  final int index;
  const ClassesListSelected(this.index);

  @override
  List<Object?> get props => [index];
}

class ClassesListShouldTakeTrackedTest extends ClassesListEvent {}

class ClassesListAddingTrackedTestCancelled extends ClassesListEvent {}

class ClassesListFilledTrackedTest extends ClassesListEvent {
  final String key;
  const ClassesListFilledTrackedTest(this.key);

  @override
  List<Object?> get props => [key];
}