import 'package:flutter/material.dart';
import 'package:testing_app/main/service/main_service_impl.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/subjectsList/bloc/subjects_list_bloc.dart';
import 'package:testing_app/main/subjectsList/widgets/subjects_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectsListPage extends StatelessWidget {
  final ClassDto schoolClass;
  const SubjectsListPage({super.key, required this.schoolClass});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectsListBloc(MainServiceImpl(), schoolClass),
      child: const SubjectsListWidget(),
    );
  }
}
