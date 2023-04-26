import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/chaptersList/bloc/chapters_list_bloc.dart';
import 'package:testing_app/main/chaptersList/widgets/chapters_list_widget.dart';
import 'package:testing_app/main/service/main_service_impl.dart';

class ChaptersListPage extends StatelessWidget {
  const ChaptersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChaptersListBloc(MainServiceImpl()),
      child: const ChaptersListWidget(),
    );
  }
}
