part of 'classes_list_bloc.dart';

@immutable
abstract class ClassesListEvent extends Equatable {
  const ClassesListEvent();

  @override
  List<Object?> get props => [];
}

class ClassesListNeedData extends ClassesListEvent {}

class ClassesListSelected extends ClassesListEvent {
  final int index;
  const ClassesListSelected(this.index);

  @override
  List<Object?> get props => [index];
}