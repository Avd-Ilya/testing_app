import 'package:core/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/chaptersList/bloc/chapters_list_bloc.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/testsList/page/tests_list_page.dart';

class ChaptersListWidget extends StatefulWidget {
  const ChaptersListWidget({super.key});

  @override
  State<ChaptersListWidget> createState() => _ChaptersListWidgetState();
}

class _ChaptersListWidgetState extends State<ChaptersListWidget> {
  List<ChapterDto> chapters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главы'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ChaptersListBloc, ChaptersListState>(
            builder: (context, state) {
              if (state is ChaptersListInitial) {
                context.read<ChaptersListBloc>().add(ChaptersListNeedData());
              }
              if (state is ChaptersListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ChaptersListError) {
                showAlertDialog(context, state.message);
              }
              if (state is ChaptersListLoaded) {
                chapters = state.chapters;
              }
              if (state is ChaptersListShowTopics) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TestsListPage();
                      },
                    ),
                  ).then((value) {
                    context.read<ChaptersListBloc>().add(ChaptersListNeedData());
                  });
                });
              }
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) {
                  return const Divider(
                    endIndent: 20,
                    indent: 20,
                    thickness: 1,
                    height: 5,
                  );
                },
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ChaptersListBloc>()
                          .add(ChaptersListSelected(index));
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(chapters[index].name ?? '',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500)),
                          Expanded(child: Container()),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
