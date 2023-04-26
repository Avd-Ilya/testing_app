part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String fio;
  final String email;
  final String password;
  final String repeatedPassword;
  const SignUpButtonPressed({required this.fio,required this.email, required this.password, required this.repeatedPassword});

  @override
  List<Object?> get props => [fio, email, password, repeatedPassword];
}