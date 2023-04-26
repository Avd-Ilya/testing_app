import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/main_service_impl.dart';
import 'package:testing_app/main/testsList/bloc/tests_list_bloc.dart';
import 'package:testing_app/main/testsList/widgets/tests_list_widget.dart';

class TestsListPage extends StatelessWidget {
  const TestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestsListBloc(MainServiceImpl()),
      child: const TestsListWidget(),
    );
  }
}
