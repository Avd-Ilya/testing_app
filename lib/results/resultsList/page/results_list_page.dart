import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/results/resultsList/bloc/results_list_bloc.dart';
import 'package:testing_app/results/resultsList/widgets/results_list_widget.dart';

class ResultsListPage extends StatefulWidget {
  const ResultsListPage({super.key});

  @override
  State<ResultsListPage> createState() => _ResultsListPageState();
}

class _ResultsListPageState extends State<ResultsListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsListBloc(),
      child: const ResultsListWidget(),
    );
  }
}