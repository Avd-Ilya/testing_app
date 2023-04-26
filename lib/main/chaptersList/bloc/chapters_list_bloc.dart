import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';

part 'chapters_list_event.dart';
part 'chapters_list_state.dart';

class ChaptersListBloc extends Bloc<ChaptersListEvent, ChaptersListState> {
  final MainService mainService;
  List<ChapterDto> chapters = [];

  ChaptersListBloc(this.mainService) : super(ChaptersListInitial()) {
    on<ChaptersListNeedData>((event, emit) async {
      emit(ChaptersListLoading());
      final response = await mainService.getChapters();

      response.fold(
        (exception) {
          emit(ChaptersListError(exception.message));
        },
        (value) {
          if (value != null) {
            chapters = value;
            emit(ChaptersListLoaded(chapters));
          }
        },
      );
    });

    on<ChaptersListSelected>((event, emit) {
      emit(ChaptersListShowTopics(chapters[event.index]));
    });
  }
}
