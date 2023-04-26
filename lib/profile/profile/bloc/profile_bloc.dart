import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/profile/service/profile_service.dart';
import 'package:flutter/material.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;
  String fio = '';
  String email = '';

  ProfileBloc(this.profileService) : super(const ProfileInitial('', '')) {
    on<ProfileNeedData>((event, emit) async {
      final response = await profileService.profile();

      response.fold((exception) {
        emit(ProfileError(fio, email, exception.message));
      }, (value) {
        if (value != null) {
          fio = value.fio;
          email = value.username;
          emit(ProfileLoaded(fio, email));
        } else {
          debugPrint('error value');
        }
      });
    });

    on<ProfileShouldShowTrackedTests>((event, emit) {
      emit(ProfileShowTrackedTests(fio, email));
    });

    on<ProfileReterned>((event, emit) {
      emit(ProfileInitial(fio, email));
    });
  }
}
