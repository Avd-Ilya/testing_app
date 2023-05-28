import 'package:bloc/bloc.dart';
import 'package:core/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_app/profile/service/profile_service.dart';
import './nav_bar_items.dart';
import 'package:flutter/material.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final ProfileService profileService;
  var currentItem = NavbarItem.home;
  NavigationCubit({required this.profileService})
      : super(NavigationState(NavbarItem.init, 0, false));

  Future<NavigationState> isAuth() async {
    var token = await Shared().getToken();
    if (token == null) {
      currentItem = NavbarItem.auth;
      return NavigationState(NavbarItem.auth, 3, false);
    }
    var response = await profileService.profile();
    var user;
    response.fold(
      (exception) {
        currentItem = NavbarItem.auth;
        return NavigationState(NavbarItem.auth, 3, false);
      },
      (value) {
        user = value;
      },
    );
    if (user == null) {
      currentItem = NavbarItem.auth;
      return NavigationState(NavbarItem.auth, 3, false);
    } else {
      currentItem = NavbarItem.home;
      return NavigationState(NavbarItem.home, 0, false);
    }
  }

  void getNavBarItem(NavbarItem navbarItem) {
    debugPrint('${currentItem}');
    switch (navbarItem) {
      case NavbarItem.home:
        currentItem == NavbarItem.home
            ? emit(NavigationState(NavbarItem.home, 0, true))
            : emit(NavigationState(NavbarItem.home, 0, false));
        currentItem = NavbarItem.home;
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            emit(NavigationUpdated(NavbarItem.home, 0, false));
          },
        );
        break;
      case NavbarItem.results:
        currentItem == NavbarItem.results
            ? emit(NavigationState(NavbarItem.results, 1, true))
            : emit(NavigationState(NavbarItem.results, 1, false));
        currentItem = NavbarItem.results;
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            emit(NavigationUpdated(NavbarItem.results, 1, false));
          },
        );
        break;
      case NavbarItem.profile:
        currentItem == NavbarItem.profile
            ? emit(NavigationState(NavbarItem.profile, 2, true))
            : emit(NavigationState(NavbarItem.profile, 2, false));
        currentItem = NavbarItem.profile;
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            emit(NavigationUpdated(NavbarItem.profile, 2, false));
          },
        );
        break;
      case NavbarItem.auth:
        emit(NavigationState(NavbarItem.auth, 3, false));
        break;
    }
  }

  void onAppear() async {
    debugPrint('onAppear');
    var state = await isAuth();
    emit(state);
  }
}
