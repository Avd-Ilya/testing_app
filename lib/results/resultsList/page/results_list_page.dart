import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/results/resultsList/bloc/results_list_bloc.dart';
import 'package:testing_app/results/resultsList/widgets/results_list_widget.dart';
import 'package:testing_app/results/service/results_service_impl.dart';

class ResultsListPage extends StatefulWidget {
  const ResultsListPage({super.key});

  @override
  State<ResultsListPage> createState() => _ResultsListPageState();
}

class _ResultsListPageState extends State<ResultsListPage> {
  @override
  Widget build(BuildContext context) {
    return const ResultsListWidget();
    // return BlocProvider(
    //   create: (context) => ResultsListBloc(ResultsServiceImpl()),
    //   child: const ResultsListWidget(),
    // );
  }
}