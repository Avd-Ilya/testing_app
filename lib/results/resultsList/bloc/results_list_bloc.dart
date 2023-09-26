import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/results/service/results_service.dart';

part 'results_list_event.dart';
part 'results_list_state.dart';

class ResultsListBloc extends Bloc<ResultsListEvent, ResultsListState> {
  final ResultsService resultsService;
  List<PassedTestDto> passedTests = [];

  ResultsListBloc(this.resultsService) : super(const ResultsListInitial([])) {
    on<ResultsListOnAppear>((event, emit) async {
      emit(ResultsListLoading(passedTests));
      var response = await resultsService.getPassedTests();
      response.fold((exception) {
        emit(ResultsListError(passedTests, exception.message));
      }, (value) {
        if (value != null) {
          passedTests = value;
          emit(ResultsListLoaded(passedTests));
        }
      });
    });
    on<ResultsListSelected>((event, emit) {
      emit(ResultsListShowResults(passedTests, passedTests[event.index]));
    });
  }
}
