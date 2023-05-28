import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
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
                        return TestsListPage(chapterId: state.chapter.id ?? 0);
                      },
                    ),
                  ).then((value) {
                    context
                        .read<ChaptersListBloc>()
                        .add(ChaptersListNeedData());
                  });
                });
              }
              return Builder(
                builder: (context) {
                  if (chapters.isEmpty && state is ChaptersListLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ничего не найдено',
                          style: TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          height: 100,
                          width: double.infinity,
                        ),
                        ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorConstants.darkBlue),
                            ),
                            onPressed: () {
                              context
                                  .read<ChaptersListBloc>()
                                  .add(ChaptersListNeedData());
                            },
                            child: const Text('Попробовать снова')),
                      ],
                    );
                  } else {
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
                                Expanded(
                                  child: Text(chapters[index].name ?? '',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500)),
                                ),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
