import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/passed_test_request_dto.dart';
import 'package:testing_app/main/service/model/selected_option_request.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/main/service/model/user_answer_request.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final MainService mainService;
  final TestDto test;
  var selectedQuestion = 0;
  List<List<int?>> selectedAnswerOptions = [];
  List<List<int?>> coparsionAnswerOptions = [];
  var passedTestRequest= PassedTestRequestDto();
  int? trackedTestId;

  TestBloc(this.mainService, this.test, this.trackedTestId)
      : super(TestInitial(test, 0, const [], const [])) {
    on<TestOnAppear>((event, emit) {
      selectedAnswerOptions =
          List<List<int?>>.generate(test.questions.length, (_) => []);
      for (var i = 0; i < test.questions.length; i++) {
        if (test.questions[i]?.questionTypeId == 3) {
          var countLeftOptions = test.questions[i]?.answerOptions
                  ?.where((element) {
                    return element.leftOptionId == null;
                  })
                  .toList()
                  .length ??
              0;
          for (var k = 0; k < countLeftOptions; k++) {
            selectedAnswerOptions[i].add(null);
          }
        }
        if (test.questions[i]?.questionTypeId == 4) {
          for (var k = 0;
              k < (test.questions[i]?.answerOptions?.length ?? 0);
              k++) {
            selectedAnswerOptions[i].add(null);
          }
        }
      }

      coparsionAnswerOptions =
          List<List<int?>>.generate(test.questions.length, (_) => []);
      for (var i = 0; i < test.questions.length; i++) {
        if (test.questions[i]?.questionTypeId == 3) {
          var answerOptionsWithoutLeftOptions =
              test.questions[i]?.answerOptions?.where((element) {
            return element.leftOptionId != null;
          }).toList();
          for (var k = 0;
              k < (answerOptionsWithoutLeftOptions?.length ?? 0);
              k++) {
            coparsionAnswerOptions[i]
                .add(answerOptionsWithoutLeftOptions?[k].id);
          }
        }
      }
      for (var i = 0; i < test.questions.length; i++) {
        if (test.questions[i]?.questionTypeId == 4) {
          for (var k = 0;
              k < (test.questions[i]?.answerOptions?.length ?? 0);
              k++) {
            coparsionAnswerOptions[i]
                .add(test.questions[i]?.answerOptions?[k].id);
          }
        }
      }
    });
    on<TestSelectedQuestion>((event, emit) {
      selectedQuestion = event.index;
      emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
          coparsionAnswerOptions));
    });
    on<TestSelectedAnswerOption>((event, emit) {
      switch (test.questions[selectedQuestion]?.questionTypeId) {
        case 1:
          selectedAnswerOptions[selectedQuestion] = [event.index];
          emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
              coparsionAnswerOptions));
          // passedTest.userAnswerRequests?[selectedQuestion].selectedOptionRequests = [];
          // var answerOptionId = test.questions[selectedQuestion]?.answerOptions?[event.index].id;
          // passedTest.userAnswerRequests?[selectedQuestion].selectedOptionRequests?.add(SelectedOptionRequest(answerOptionId: answerOptionId));
          break;
        case 2:
          var arr = selectedAnswerOptions[selectedQuestion];
          if (arr.contains(event.index)) {
            arr.remove(event.index);
          } else {
            arr.add(event.index);
          }
          selectedAnswerOptions[selectedQuestion] = arr;
          emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
              coparsionAnswerOptions));
          break;
        case 3:
          if (selectedAnswerOptions[selectedQuestion][event.index] != null) {
            coparsionAnswerOptions[selectedQuestion]
                .add(selectedAnswerOptions[selectedQuestion][event.index]);
            selectedAnswerOptions[selectedQuestion][event.index] = null;
          }
          if (selectedAnswerOptions[selectedQuestion].contains(event.id)) {
            var index =
                selectedAnswerOptions[selectedQuestion].indexWhere((element) {
              return element == event.id;
            });
            selectedAnswerOptions[selectedQuestion][index] = null;
          }
          selectedAnswerOptions[selectedQuestion][event.index] = event.id ?? 0;
          coparsionAnswerOptions[selectedQuestion].removeWhere((element) {
            return element == event.id;
          });
          emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
              coparsionAnswerOptions));
          break;
        case 4:
          if (selectedAnswerOptions[selectedQuestion][event.index] != null) {
            coparsionAnswerOptions[selectedQuestion]
                .add(selectedAnswerOptions[selectedQuestion][event.index]);
            selectedAnswerOptions[selectedQuestion][event.index] = null;
          }
          if (selectedAnswerOptions[selectedQuestion].contains(event.id)) {
            var index =
                selectedAnswerOptions[selectedQuestion].indexWhere((element) {
              return element == event.id;
            });
            selectedAnswerOptions[selectedQuestion][index] = null;
          }
          selectedAnswerOptions[selectedQuestion][event.index] = event.id ?? 0;
          coparsionAnswerOptions[selectedQuestion].removeWhere((element) {
            return element == event.id;
          });
          emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
              coparsionAnswerOptions));
          break;
        default:
      }
    });
    on<TestNextTapped>((event, emit) {
      if (test.questions.length == selectedQuestion + 1) {
        emit(TestShouldFinish(test, selectedQuestion, selectedAnswerOptions,
            coparsionAnswerOptions));
      } else {
        selectedQuestion = selectedQuestion + 1;
        emit(TestUpdated(test, selectedQuestion, selectedAnswerOptions,
            coparsionAnswerOptions));
      }
    });
    on<TestSendTapped>((event, emit) {
      emit(TestShouldFinish(test, selectedQuestion, selectedAnswerOptions,
          coparsionAnswerOptions));
    });
    on<TestFinishAccepted>((event, emit) async {
      passedTestRequest.date = DateTime.now();
      passedTestRequest.result = null;
      passedTestRequest.testId = test.id;
      passedTestRequest.userAnswerRequests = [];
      passedTestRequest.trackedTestId = trackedTestId;
      for (var i = 0; i < test.questions.length; i++) {
        var question = test.questions[i];
        var userAnswerRequest = UserAnswerRequest(
            questionId: question?.id, selectedOptionRequests: []);
        if (question?.questionTypeId == 1 || question?.questionTypeId == 2) {
          for (var k = 0; k < (selectedAnswerOptions[i].length); k++) {
            var selectedAnswerOptionIndex = selectedAnswerOptions[i][k];
            var answerOptionId = test.questions[i]
                ?.answerOptions?[selectedAnswerOptionIndex ?? 0].id;
            var selectedOptionRequest = SelectedOptionRequest(
                position: null, answerOptionId: answerOptionId);
            userAnswerRequest.selectedOptionRequests
                ?.add(selectedOptionRequest);
          }
        }
        if (question?.questionTypeId == 3 || question?.questionTypeId == 4) {
          for (var k = 0; k < (selectedAnswerOptions[i].length); k++) {
            var selectedOptionRequest = SelectedOptionRequest(
                position: k, answerOptionId: selectedAnswerOptions[i][k]);
            userAnswerRequest.selectedOptionRequests
                ?.add(selectedOptionRequest);
          }
        }
        passedTestRequest.userAnswerRequests?.add(userAnswerRequest);
      }
      debugPrint('${passedTestRequest.toJson()}');

      emit(TestLoading(test, selectedQuestion, selectedAnswerOptions, coparsionAnswerOptions));
      final response = await mainService.postPassedTest(passedTestRequest);
      response.fold((l) {
        emit(TestError(test, selectedQuestion, selectedAnswerOptions, coparsionAnswerOptions, l.message));
      }, (value) {
        if (value != null) {
          debugPrint('Success');
          debugPrint('${value.toJson()}');
          emit(TestCompleted(test, selectedQuestion, selectedAnswerOptions, coparsionAnswerOptions, value.result ?? 0));
        }
      });

    });
  }
}
