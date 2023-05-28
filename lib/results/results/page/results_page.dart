import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/model/passed_test_dto.dart';
import 'package:testing_app/results/results/bloc/results_bloc.dart';
import 'package:testing_app/results/results/widgets/results_widget.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.passedTest});
  final PassedTestDto passedTest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsBloc(passedTest: passedTest),
      child: const ResultsWidget(),
    );
  }
}