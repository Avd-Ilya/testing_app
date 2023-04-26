import 'package:bloc/bloc.dart';
import 'package:core/shared.dart';
import 'package:equatable/equatable.dart';
import './nav_bar_items.dart';
import 'package:flutter/material.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.init, 0));

  Future<NavigationState> isAuth() async {
    var token = await Shared().getToken();
    if (token == null) {
      return NavigationState(NavbarItem.auth, 3);
    } else {
      return NavigationState(NavbarItem.home, 0);
    }

  }

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.results:
        emit(NavigationState(NavbarItem.results, 1));
        break;
      case NavbarItem.profile:
        emit(NavigationState(NavbarItem.profile, 2));
        break;
      case NavbarItem.auth:
        emit(NavigationState(NavbarItem.auth, 3));
        break;
    }
  }
  void onAppear() async {
    debugPrint('onAppear');
    var state = await isAuth();
    emit(state);
  }
}
