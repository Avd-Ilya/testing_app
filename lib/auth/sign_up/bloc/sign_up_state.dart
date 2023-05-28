part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  final Map<String, String> textFields;
  const SignUpState({required this.textFields});

  @override
  List<Object?> get props => [textFields.values.hashCode];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({required super.textFields});
}

class SignUpLoading extends SignUpState {
  const SignUpLoading({required super.textFields});
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required super.textFields, required this.message});

  @override
  List<Object?> get props => [super.props, message];
}

class SignUpSuccessedRegister extends SignUpState {
  const SignUpSuccessedRegister({required super.textFields});
}

class SignUpUpdated extends SignUpState {
  const SignUpUpdated({required super.textFields});
}