import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_dto.dart';
import 'package:testing_app/profile/service/model/tracked_test_request_dto.dart';

part 'tests_list_event.dart';
part 'tests_list_state.dart';

class TestsListBloc extends Bloc<TestsListEvent, TestsListState> {
  final MainService mainService;
  final int chapterId;
  List<TestDto> tests = [];
  var trackedTestIndex = 0;

  TestsListBloc(this.mainService, this.chapterId) : super(TestsListInitial()) {
    on<TestsListNeedData>((event, emit) async {
      emit(TestsListLoading());
      final response = await mainService.getTests(chapterId);

      response.fold(
        (exception) {
          emit(TestsListError(exception.message));
        },
        (value) {
          if (value != null) {
            tests = value;
            emit(TestsListLoaded(tests));
          }
        },
      );
    });
    on<TestsListSelected>((event, emit) {
      emit(TestsListShowTest(tests[event.index]));
    });
    on<TestsListShouldCreateTrackedTest>((event, emit) {
      trackedTestIndex = event.index;
      emit(TestsListCreatingTrackedTest(event.index));
    });
    on<TestsListCreatingTrackedTestCancelled>((event, emit) {
      emit(TestsListLoaded(tests));
    });
    on<TestsListCreateTrackedTest>((event, emit) async {
      var trackedTest = TrackedTestRequestDto();
      trackedTest.description = event.text;
      trackedTest.dateCreation = DateTime.now();
      trackedTest.testId = tests[trackedTestIndex].id;
      debugPrint('${trackedTest.toJson()}');
      final response = await mainService.createTrackedTest(trackedTest);
      response.fold(
        (exception) {
          emit(TestsListError(exception.message));
        },
        (value) {
          if (value != null) {
            emit(TestsListTrackedTestCreated(value.key ?? 'error'));
          }
        },
      );
    });
  }
}
