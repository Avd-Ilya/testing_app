import 'package:bloc/bloc.dart';
import 'package:core/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService authService;

  SignInBloc(this.authService) : super(SignInInitial()) {
    
    on<SignInButtonPressed>((event, emit) async {
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(const SignInError(message: 'Заполните все поля'));
        return;
      }

      final response = await authService.login(event.email, event.password);

      response.fold(
        (exception) {
          emit(SignInError(message: exception.message));
        },
        (value) {
          debugPrint(value);
          if (value != null && value.isNotEmpty) {
            Shared().saveToken(value);
            debugPrint('ok');
            emit(SignInSuccessLogin());
          } else {
            emit(const SignInError(message: 'empty token'));
          }
        },
      );
    });

    on<SignInShouldShowRegistration>((event, emit) {
      emit(SignInShowRegistration());
    });

    on<SignInReterned>((event, emit) {
      emit(SignInInitial());
    });
  }
}
