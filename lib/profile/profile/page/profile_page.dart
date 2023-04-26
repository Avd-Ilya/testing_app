import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/profile/profile/bloc/profile_bloc.dart';
import 'package:testing_app/profile/service/profile_service_impl.dart';
import 'package:testing_app/profile/profile/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(ProfileServiceImpl()),
      child: const ProfileWidget(),
    );
  }
}


