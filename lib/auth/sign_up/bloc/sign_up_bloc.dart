import 'package:bloc/bloc.dart';
import 'package:core/shared.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;

  SignUpBloc(this.authService) : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      if (event.fio.isEmpty || event.email.isEmpty || event.password.isEmpty || event.repeatedPassword.isEmpty) {
        emit(const SignUpError(message: 'Заполните все поля'));
        return;
      }

      final response = await authService.register(event.email, event.password, event.fio);

      response.fold(
        (exception) {
          emit(SignUpError(message: exception.message));
        },
        (value) {
          debugPrint(value);
          if (value != null && value.isNotEmpty) {
            Shared().saveToken(value);
            emit(SignUpSuccessedRegister());
          } else {
            emit(const SignUpError(message: 'empty token'));
          }
        },
      );


    });
  }
}
