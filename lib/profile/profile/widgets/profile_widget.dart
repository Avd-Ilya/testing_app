import 'package:core/constants.dart';
import 'package:core/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/navigation/navigation_cubit.dart';
import 'package:testing_app/profile/profile/bloc/profile_bloc.dart';
import 'package:testing_app/profile/profile/widgets/profile_avatar_info_widget.dart';
import 'package:testing_app/profile/profile/widgets/profile_info_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/profile/tracked%20tests/trackedTestsList/page/tracked_tests_list_page.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  void logout() async {
    debugPrint('logout button tapped');
    Shared().deleteToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileBloc>().add(ProfileNeedData());
        }
        if (state is ProfileShowTrackedTests) {
          debugPrint('show tracked tests');
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const TrackedTestsListPage();
                },
              ),
            ).then((value) {
              context.read<ProfileBloc>().add(ProfileReterned());
            });
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Профиль'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  logout();
                  context.read<NavigationCubit>().onAppear();
                },
              ),
            ],
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileAvatarInfoWidget(fio: state.fio, email: state.email),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 50,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(10),
                        color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Отслеживаемые тесты'),
                            Icon(Icons.navigate_next)
                          ],
                        ),
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(ProfileShouldShowTrackedTests());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ProfileInfoWidget(fio: state.fio, email: state.email),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
