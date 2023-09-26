import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';

part 'classes_list_event.dart';
part 'classes_list_state.dart';

class ClassesListBloc extends Bloc<ClassesListEvent, ClassesListState> {
  MainService mainService;

  ClassesListBloc(this.mainService) : super(ClassesListInitial()) {
    List<ClassDto> classes = [];

    on<ClassesListOnAppear>((event, emit) async {
      emit(ClassesListLoading());
      final response = await mainService.getClasses();

      response.fold(
        (exception) {
          emit(ClassesListError(exception.message));
        },
        (value) {
          if (value != null) {
            classes = value;
            emit(ClassesListLoaded(classes));
          }
        },
      );
    });
    on<ClassesListTabSelected>((event, emit) {
      emit(ClassesListPopToRoot());
    });
    on<ClassesListSelected>((event, emit) {
      emit(ClassesListShowSubjects(classes[event.index]));
    });
    on<ClassesListShouldTakeTrackedTest>((event, emit) {
      emit(ClassesListShowAddTrackedTest());
    });
    on<ClassesListAddingTrackedTestCancelled>((event, emit) {
      emit(ClassesListLoaded(classes));
    });
    on<ClassesListFilledTrackedTest>((event, emit) async {
      final response = await mainService.getTrackedTest(event.key);

      await response.fold(
        (exception) {
          emit(ClassesListError(exception.message));
        },
        (trackedTest) async {
          if (trackedTest?.testId != null) {
            final testResponse = await mainService.getTest(trackedTest?.testId ?? 0);
            testResponse.fold((exception) {
              emit(ClassesListError(exception.message));
            }, (test) {
              if (test != null) {
                emit(ClassesListShowTrackedTest(test, trackedTest?.id));
              }
            });
          } else {
            emit(const ClassesListError('Тест не найден'));
          }
        },
      );
    });
  }
}
