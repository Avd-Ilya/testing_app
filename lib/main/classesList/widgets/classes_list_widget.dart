import 'package:core/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/classesList/bloc/classes_list_bloc.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/subjectsList/page/subjects_list_page.dart';

class ClassesListWidget extends StatefulWidget {
  const ClassesListWidget({super.key});

  @override
  State<ClassesListWidget> createState() => _ClassesListWidgetState();
}

class _ClassesListWidgetState extends State<ClassesListWidget> {
  List<ClassDto> classes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Классы"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ClassesListBloc, ClassesListState>(
            builder: (context, state) {
              if (state is ClassesListInitial) {
                context.read<ClassesListBloc>().add(ClassesListNeedData());
                return Container();
              }
              if (state is ClassesListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ClassesListError) {
                showAlertDialog(context, state.message);
              }
              if (state is ClassesListShowSubjects) {
                Future.delayed(
                  Duration.zero,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SubjectsListPage(schoolClass: state.schoolClass);
                        },
                      ),
                    ).then((value) {
                      debugPrint('returned');
                      context.read<ClassesListBloc>().add(ClassesListNeedData());
                    });
                  },
                );
              }
              if (state is ClassesListLoaded) {
                classes = state.classes;
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
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ClassesListBloc>()
                          .add(ClassesListSelected(index));
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(classes[index].name ?? '',
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
