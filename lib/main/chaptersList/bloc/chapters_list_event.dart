part of 'chapters_list_bloc.dart';

@immutable
abstract class ChaptersListEvent extends Equatable {
  const ChaptersListEvent();

  @override
  List<Object?> get props => [];
}

class ChaptersListNeedData extends ChaptersListEvent {}

class ChaptersListSelected extends ChaptersListEvent {
  final int index;
  const ChaptersListSelected(this.index);

  @override
  List<Object?> get props => [index];
}