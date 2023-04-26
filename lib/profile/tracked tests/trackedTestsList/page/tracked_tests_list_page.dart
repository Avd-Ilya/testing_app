import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/profile/tracked%20tests/trackedTestsList/bloc/tracked_tests_list_bloc.dart';
import 'package:testing_app/profile/tracked%20tests/trackedTestsList/widgets/tracked_tests_list_widget.dart';

class TrackedTestsListPage extends StatefulWidget {
  const TrackedTestsListPage({super.key});

  @override
  State<TrackedTestsListPage> createState() => _TrackedTestsListPageState();
}

class _TrackedTestsListPageState extends State<TrackedTestsListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackedTestsListBloc(),
      child: const TrackedTestsListWidget(),
    );
  }
}