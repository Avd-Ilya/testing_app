// import 'package:bloc_navigation_tutorial/logic/navigation/constants/nav_bar_items.dart';
// import 'package:bloc_navigation_tutorial/logic/navigation/navigation_cubit.dart';
// import 'package:bloc_navigation_tutorial/presentation/screens/home_screen.dart';
// import 'package:bloc_navigation_tutorial/presentation/screens/profile_screen.dart';
// import 'package:bloc_navigation_tutorial/presentation/screens/settings_screen.dart';
// import 'package:feature_profile/page/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/navigation/nav_bar_items.dart';
import 'package:testing_app/navigation/navigation_cubit.dart';
import 'package:testing_app/pages/account_page.dart';
import 'package:testing_app/pages/login_page.dart';
import 'package:testing_app/pages/login_password_page.dart';
import 'package:testing_app/profile/page/profile_page.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final screens = const [
    LoginPage(),
    LoginPasswordPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: Colors.lightGreen,
            unselectedItemColor: Colors.black45,
            selectedItemColor: Colors.black,
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add_check,
                ),
                label: 'Результаты',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Профиль',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.results);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              }
            },
          );
        },
      ),
      // body: BlocBuilder<NavigationCubit, NavigationState>(
      //   builder: (context, state) {
      //     if (state.navbarItem == NavbarItem.home) {
      //       return LoginPage();
      //     } else if (state.navbarItem == NavbarItem.settings) {
      //       return LoginPasswordPage();
      //     } else if (state.navbarItem == NavbarItem.profile) {
      //       return AccountPage();
      //     }
      //     return Container();
      //   }
      // ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return IndexedStack(
          index: state.index,
          children: screens,
        );
      }),
    );
  }
}