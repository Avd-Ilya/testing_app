import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/profile/activity_tracked_tests/bloc/activity_tracked_tests_bloc.dart';
import 'package:testing_app/profile/activity_tracked_tests/widgets/activity_tracked_tests_widget.dart';
import 'package:testing_app/profile/service/profile_service_impl.dart';

class ActivityTrackedTestsPage extends StatelessWidget {
  final int trackedTestId;
  final String tarckedTestKey;
  const ActivityTrackedTestsPage({super.key, required this.trackedTestId, required this.tarckedTestKey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityTrackedTestsBloc(profileService: ProfileServiceImpl(), trackedTestId: trackedTestId, tarckedTestKey: tarckedTestKey),
      child: const ActivityTrackedTestsWidget(),
    );
  }
}