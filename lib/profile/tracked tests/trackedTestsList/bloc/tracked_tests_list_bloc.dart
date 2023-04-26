import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tracked_tests_list_event.dart';
part 'tracked_tests_list_state.dart';

class TrackedTestsListBloc extends Bloc<TrackedTestsListEvent, TrackedTestsListState> {
  TrackedTestsListBloc() : super(TrackedTestsListInitial()) {
    on<TrackedTestsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
