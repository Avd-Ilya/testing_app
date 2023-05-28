import 'package:bloc/bloc.dart';
import 'package:core/config.dart';
import 'package:core/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService authService;
  final Map<String, String> textFields = {};

  bool validate(String key, String value) {
    bool isValid = true;
    switch (key) {
      case 'email':
        if (value.isEmpty) {
          isValid = false;
          textFields[key] = 'Обязательное поле';
        } else if (value.length < 6) {
          isValid = false;
          textFields[key] = 'Минимум символов - 6';
        } else {
          if (Config.emailRegExp.hasMatch(value)) {
            textFields[key] = ''; 
          } else {
            isValid = false;
            textFields[key] = 'Неверный формат email';
          }
        }

        break;
      case 'password':
        if (value.isEmpty) {
          isValid = false;
          textFields[key] = 'Обязательное поле';
        } else if (value.length < 4) {
          isValid = false;
          textFields[key] = 'Минимум символов - 4';
        } else {
          textFields[key] = '';
        }
        break;
      default:
    }
    return isValid;
  }

  SignInBloc(this.authService) : super(const SignInInitial(textFields: {})) {
    on<SignInTextChanged>((event, emit) {
      validate(event.key, event.value);
      emit(SignInUpdated(textFields: textFields));
    });
    on<SignInButtonPressed>((event, emit) async {
      bool isValid = true;
      for (var key in event.textFields.keys) {
        bool valid = validate(key, event.textFields[key] ?? '');
        if (!valid) {
          isValid = valid;
        }
      }
      emit(SignInUpdated(textFields: textFields));
      if (isValid) {
        final response = await authService.login(
            event.textFields['email'] ?? '',
            event.textFields['password'] ?? '');
        response.fold(
          (exception) {
            emit(SignInError(
                textFields: textFields, message: exception.message));
          },
          (value) {
            debugPrint(value);
            if (value != null && value.isNotEmpty) {
              Shared().saveToken(value);
              debugPrint('ok');
              emit(SignInSuccessLogin(textFields: textFields));
            } else {
              emit(SignInError(textFields: textFields, message: 'empty token'));
            }
          },
        );
      }
    });
    on<SignInShouldShowRegistration>((event, emit) {
      emit(SignInShowRegistration(textFields: textFields));
    });
    on<SignInReterned>((event, emit) {
      emit(SignInInitial(textFields: textFields));
    });
  }
}
