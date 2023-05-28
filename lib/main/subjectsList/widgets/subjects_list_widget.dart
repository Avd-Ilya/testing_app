import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/chaptersList/page/chapters_list_page.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';
import 'package:testing_app/main/subjectsList/bloc/subjects_list_bloc.dart';

class SubjectsListWidget extends StatefulWidget {
  const SubjectsListWidget({super.key});

  @override
  State<SubjectsListWidget> createState() => _SubjectsListWidgetState();
}

class _SubjectsListWidgetState extends State<SubjectsListWidget> {
  List<SubjectDto> subjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Предметы')),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<SubjectsListBloc, SubjectsListState>(
            builder: (context, state) {
              if (state is SubjectsListInitial) {
                context.read<SubjectsListBloc>().add(SubjectsListNeedData());
              }
              if (state is SubjectsListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is SubjectsListError) {
                showAlertDialog(context, state.message);
              }
              if (state is SubjectsListLoaded) {
                subjects = state.subjects;
              }
              if (state is SubjectsListShowChapters) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChaptersListPage(
                            subjectId: state.subject.id ?? 0);
                      },
                    ),
                  ).then((value) {
                    context
                        .read<SubjectsListBloc>()
                        .add(SubjectsListNeedData());
                  });
                });
              }
              return Builder(
                builder: (context) {
                  if (subjects.isEmpty && state is SubjectsListLoaded) {
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
                                  .read<SubjectsListBloc>()
                                  .add(SubjectsListNeedData());
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
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<SubjectsListBloc>()
                                .add(SubjectsListSelected(index));
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(subjects[index].name ?? '',
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
