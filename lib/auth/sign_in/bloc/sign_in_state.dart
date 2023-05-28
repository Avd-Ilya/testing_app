part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState extends Equatable {
  final Map<String, String> textFields;
  const SignInState({required this.textFields});

  @override
  List<Object?> get props => [textFields.values.hashCode];
}

class SignInInitial extends SignInState {
  const SignInInitial({required super.textFields});
}

class SignInLoading extends SignInState {
  const SignInLoading({required super.textFields});
}

class SignInSuccessLogin extends SignInState {
  const SignInSuccessLogin({required super.textFields});
}

class SignInError extends SignInState {
  final String message;

  const SignInError({required super.textFields, required this.message});

  @override
  List<Object?> get props => [super.props, message];
}

class SignInShowRegistration extends SignInState {
  const SignInShowRegistration({required super.textFields});
}

class SignInUpdated extends SignInState {
  const SignInUpdated({required super.textFields});
}