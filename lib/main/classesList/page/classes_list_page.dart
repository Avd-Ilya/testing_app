import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/classesList/bloc/classes_list_bloc.dart';
import 'package:testing_app/main/classesList/widgets/classes_list_widget.dart';
import 'package:testing_app/main/service/main_service_impl.dart';

class ClassesListPage extends StatelessWidget {
  const ClassesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassesListBloc(MainServiceImpl()),
      child: const ClassesListWidget(),
    );
  }
}