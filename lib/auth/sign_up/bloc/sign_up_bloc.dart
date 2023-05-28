import 'package:core/config.dart';
import 'package:core/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;
  final Map<String, String> textFields = {};

  bool validate(String key, String value, {String repeatedValue = ''}) {
    bool isValid = true;
    switch (key) {
      case 'fio':
        if (value.isEmpty) {
          isValid = false;
          textFields[key] = 'Обязательное поле';
        } else if (value.length < 2) {
          isValid = false;
          textFields[key] = 'Минимум символов - 2';
        } else {
          textFields[key] = '';
        }
        break;
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
        if (value != repeatedValue) {
          textFields['repeatedPassword'] = 'Пароли не совпадают';
        } else {
          textFields['repeatedPassword'] = '';
        }

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
      case 'repeatedPassword':
        if (value.isEmpty) {
          isValid = false;
          textFields[key] = 'Обязательное поле';
        } else if (value != repeatedValue) {
          debugPrint(repeatedValue);
          isValid = false;
          textFields[key] = 'Пароли не совпадают';
        } else {
          textFields[key] = '';
        }
        break;
      default:
    }
    return isValid;
  }

  SignUpBloc(this.authService) : super(const SignUpInitial(textFields: {})) {
    on<SignUpTextChanged>((event, emit) {
      validate(event.key, event.value, repeatedValue: event.repeatedValue);
      emit(SignUpUpdated(textFields: textFields));
    });
    on<SignUpButtonPressed>((event, emit) async {
      bool isValid = true;
      for (var key in event.textFields.keys) {
        if (key == 'repeatedPassword') {
          bool valid = validate(key, event.textFields[key] ?? '',
              repeatedValue: event.textFields['password'] ?? '');
          if (!valid) {
            isValid = valid;
          }
        } else {
          bool valid = validate(key, event.textFields[key] ?? '');
          if (!valid) {
            isValid = valid;
          }
        }
      }
      emit(SignUpUpdated(textFields: textFields));
      if (isValid) {
        final response = await authService.register(
          event.textFields['email'] ?? '',
          event.textFields['password'] ?? '',
          event.textFields['fio'] ?? '',
        );
        response.fold(
          (exception) {
            emit(SignUpError(
                textFields: textFields, message: exception.message));
          },
          (value) {
            debugPrint(value);
            if (value != null && value.isNotEmpty) {
              Shared().saveToken(value);
              emit(SignUpSuccessedRegister(textFields: textFields));
            } else {
              emit(SignUpError(textFields: textFields, message: 'empty token'));
            }
          },
        );
      }
    });
  }
}
