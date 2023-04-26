import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'results_list_event.dart';
part 'results_list_state.dart';

class ResultsListBloc extends Bloc<ResultsListEvent, ResultsListState> {
  ResultsListBloc() : super(ResultsListInitial()) {
    on<ResultsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
