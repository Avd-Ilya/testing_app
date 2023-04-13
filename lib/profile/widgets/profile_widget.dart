import 'package:core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/profile/bloc/profile_bloc.dart';
import 'package:testing_app/profile/widgets/profile_avatar_info_widget.dart';
import 'package:testing_app/profile/widgets/profile_info_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  void logout() async {
    debugPrint('logout button tapped');
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Open shopping cart',
            onPressed: () {
              logout();
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
                ProfileAvatarInfoWidget(
                    fio: 'Иванов Иван', email: 'ivanov@mail.ru'),
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
                      debugPrint('traked tests button tapped');
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ProfileInfoWidget(
                    fio: 'Иванов Иван Иванович', email: 'ivanov@mail.ru')
              ],
            ),
          );
        },
      ),
    );
  }
}
