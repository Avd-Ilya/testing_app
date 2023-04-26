import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/main_service_impl.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/main/test/bloc/test_bloc.dart';
import 'package:testing_app/main/test/widgets/test_widget.dart';

class TestPage extends StatelessWidget {
  TestDto test;
  TestPage({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestBloc(MainServiceImpl(), test),
      child: const TestWidget(),
    );
  }
}