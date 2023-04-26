part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpSuccessedRegister extends SignUpState {}