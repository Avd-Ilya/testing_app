part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final Map<String, String> textFields;
  const SignUpButtonPressed({required this.textFields});

  @override
  List<Object?> get props => [textFields.values.hashCode];
}

class SignUpTextChanged extends SignUpEvent {
  final String key;
  final String value;
  final String repeatedValue;
  const SignUpTextChanged(
      {required this.key, required this.value, this.repeatedValue = ''});

  @override
  List<Object> get props => [key, value, repeatedValue];
}
