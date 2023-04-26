import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/test_dto.dart';

part 'tests_list_event.dart';
part 'tests_list_state.dart';

class TestsListBloc extends Bloc<TestsListEvent, TestsListState> {
  final MainService mainService;
  List<TestDto> tests = [];

  TestsListBloc(this.mainService) : super(TestsListInitial()) {
    on<TestsListNeedData>((event, emit) async {
      emit(TestsListLoaded(tests));
      final response = await mainService.getTests();

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
  }
}
