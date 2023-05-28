import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/chaptersList/bloc/chapters_list_bloc.dart';
import 'package:testing_app/main/chaptersList/widgets/chapters_list_widget.dart';
import 'package:testing_app/main/service/main_service_impl.dart';

class ChaptersListPage extends StatelessWidget {
  final int subjectId;
  const ChaptersListPage({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ChaptersListBloc(MainServiceImpl(), subjectId),
      child: const ChaptersListWidget(),
    );
  }
}
