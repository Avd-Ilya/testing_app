part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccessLogin extends SignInState {}

class SignInError extends SignInState {
  final String message;

  const SignInError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignInShowRegistration extends SignInState {}
