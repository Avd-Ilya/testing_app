part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  final String fio;
  final String email;
  const ProfileState(this.fio, this.email);

  @override
  List<Object?> get props => [fio, email];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial(super.fio, super.email);
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.fio, super.email);
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(super.fio, super.email);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(super.fio, super.email, this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileShowTrackedTests extends ProfileState {
  const ProfileShowTrackedTests(super.fio, super.email);
}