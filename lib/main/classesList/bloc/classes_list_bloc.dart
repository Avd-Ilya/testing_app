import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/class_dto.dart';

part 'classes_list_event.dart';
part 'classes_list_state.dart';

class ClassesListBloc extends Bloc<ClassesListEvent, ClassesListState> {
  MainService mainService;

  ClassesListBloc(this.mainService) : super(ClassesListInitial()) {
    List<ClassDto> classes = [];

    on<ClassesListNeedData>((event, emit) async {
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

    on<ClassesListSelected>((event, emit) {
      emit(ClassesListShowSubjects(classes[event.index]));
    });
  }
}

      // final response = await profileService.profile();

      // response.fold((exception) {
      //   emit(ProfileError(fio, email, exception.message));
      // }, (value) {
      //   if (value != null) {
      //     fio = value.fio;
      //     email = value.username;
      //     emit(ProfileLoaded(fio, email));
      //   } else {
      //     debugPrint('error value');
      //   }
      // });