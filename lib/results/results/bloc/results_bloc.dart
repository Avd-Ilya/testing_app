import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  final PassedTestDto passedTest;
  int selectedQuestion = 0;
  ResultsBloc({required this.passedTest})
      : super(ResultsInitial(passedTest, 0)) {
    on<ResultsSelectedQuestion>((event, emit) {
      selectedQuestion = event.index;
      emit(ResultsUpdated(passedTest, selectedQuestion));
    });
    on<ResultsNextTapped>((event, emit) {
      if (passedTest.test?.questions.length == selectedQuestion + 1) {
        emit(ResultsShouldFinish(passedTest, selectedQuestion));
      } else {
        selectedQuestion = selectedQuestion + 1;
        emit(ResultsUpdated(passedTest, selectedQuestion));
      }
    });
    on<ResultsFinishAccepted>((event, emit) {
      emit(ResultsClose(passedTest, selectedQuestion));
    });
    on<ResultsOnAppear>((event, emit) {
      emit(ResultsUpdated(passedTest, selectedQuestion));
    });
  }
}
