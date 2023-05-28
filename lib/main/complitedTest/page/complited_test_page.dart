import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/complitedTest/bloc/complited_test_bloc.dart';
import 'package:testing_app/main/complitedTest/widgets/complited_test_widget.dart';

class ComplitedTestPage extends StatelessWidget {
  double result;
  ComplitedTestPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComplitedTestBloc(),
      child: ComplitedTestWidget(result: result,),
    );
  }
}