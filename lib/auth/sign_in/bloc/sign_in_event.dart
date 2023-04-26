part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInButtonPressed extends SignInEvent {
  final String email;
  final String password;

  const SignInButtonPressed({required this.email, required this.password});

@override
  List<Object?> get props => [email, password];
}

class SignInShouldShowRegistration extends SignInEvent {}

class SignInReterned extends SignInEvent {}