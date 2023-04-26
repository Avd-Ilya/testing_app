part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileNeedData extends ProfileEvent {}

class ProfileShouldShowTrackedTests extends ProfileEvent {}

class ProfileReterned extends ProfileEvent {}