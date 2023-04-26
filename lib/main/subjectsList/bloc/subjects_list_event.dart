part of 'subjects_list_bloc.dart';

@immutable
abstract class SubjectsListEvent extends Equatable {
  const SubjectsListEvent();

  @override
  List<Object?> get props => [];
}

class SubjectsListNeedData extends SubjectsListEvent {}

class SubjectsListSelected extends SubjectsListEvent {
  final int index;
  const SubjectsListSelected(this.index);

  @override
  List<Object?> get props => [index];
}
