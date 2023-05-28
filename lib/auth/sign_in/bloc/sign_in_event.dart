part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInButtonPressed extends SignInEvent {
  final Map<String, String> textFields;

  const SignInButtonPressed({required this.textFields});

  @override
  List<Object?> get props => [textFields.values.hashCode];
}

class SignInShouldShowRegistration extends SignInEvent {}

class SignInReterned extends SignInEvent {}

class SignInTextChanged extends SignInEvent {
  final String key;
  final String value;
  const SignInTextChanged({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}
