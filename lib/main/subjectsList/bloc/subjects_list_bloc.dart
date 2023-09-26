import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';

part 'subjects_list_event.dart';
part 'subjects_list_state.dart';

class SubjectsListBloc extends Bloc<SubjectsListEvent, SubjectsListState> {
  final MainService mainService;
  final ClassDto schoolClass;

  SubjectsListBloc(this.mainService, this.schoolClass) : super(SubjectsListInitial()) {
    List<SubjectDto> subjects = [];

    on<SubjectsListNeedData>((event, emit) async {
      final response = await mainService.getSubjects(schoolClass.id ?? 0);

      response.fold(
        (exception) {
          emit(SubjectsListError(exception.message));
        },
        (value) {
          if (value != null) {
            subjects = value;
            emit(SubjectsListLoaded(subjects));
          }
        },
      );
    });

    on<SubjectsListSelected>((event, emit) {
      emit(SubjectsListShowChapters(subjects[event.index]));
    });
  }
}
