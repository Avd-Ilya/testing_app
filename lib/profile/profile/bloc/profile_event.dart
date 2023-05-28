part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileOnAppear extends ProfileEvent {}

class ProfileTabSelected extends ProfileEvent {}

class ProfileShouldShowTrackedTests extends ProfileEvent {}

class ProfileReterned extends ProfileEvent {}

class ProfileDeleteAccountButtonTapped extends ProfileEvent {}