import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'complited_test_event.dart';
part 'complited_test_state.dart';

class ComplitedTestBloc extends Bloc<ComplitedTestEvent, ComplitedTestState> {
  ComplitedTestBloc() : super(ComplitedTestInitial()) {
    on<ComplitedTestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
