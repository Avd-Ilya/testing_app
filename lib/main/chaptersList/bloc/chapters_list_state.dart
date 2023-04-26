part of 'chapters_list_bloc.dart';

@immutable
abstract class ChaptersListState extends Equatable {
  const ChaptersListState();

  @override
  List<Object?> get props => [];
}

class ChaptersListInitial extends ChaptersListState {}

class ChaptersListLoading extends ChaptersListState {}

class ChaptersListLoaded extends ChaptersListState {
  final List<ChapterDto> chapters;
  const ChaptersListLoaded(this.chapters);

  @override
  List<Object?> get props => [chapters];
}

class ChaptersListError extends ChaptersListState {
  final String message;
  const ChaptersListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChaptersListShowTopics extends ChaptersListState {
  final ChapterDto chapter;
  const ChaptersListShowTopics(this.chapter);

  @override
  List<Object?> get props => [chapter];
}