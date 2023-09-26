import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/classesList/bloc/classes_list_bloc.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/subjectsList/page/subjects_list_page.dart';
import 'package:testing_app/main/test/page/test_page.dart';

class ClassesListWidget extends StatefulWidget {
  const ClassesListWidget({super.key});

  @override
  State<ClassesListWidget> createState() => _ClassesListWidgetState();
}

class _ClassesListWidgetState extends State<ClassesListWidget> {
  late TextEditingController _textFieldController;
  List<ClassDto> classes = [];

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void showAddTrackedTestAlert(BuildContext context) {
    CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text("Пройти тест"),
      ),
      content: Container(
        color: Colors.white,
        child: Material(
          child: CupertinoTextField(
            controller: _textFieldController,
            suffix: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _textFieldController.clear();
              },
            ),
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            context
                .read<ClassesListBloc>()
                .add(ClassesListAddingTrackedTestCancelled());
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Отменить'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            context
                .read<ClassesListBloc>()
                .add(ClassesListFilledTrackedTest(_textFieldController.text));
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text(
            'Пройти',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );

    // show the dialog
    Future.delayed(
      Duration.zero,
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return cupertinoAlert;
          },
        ).then((value) {
          context
              .read<ClassesListBloc>()
              .add(ClassesListAddingTrackedTestCancelled());
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Классы"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context
                  .read<ClassesListBloc>()
                  .add(ClassesListShouldTakeTrackedTest());
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ClassesListBloc, ClassesListState>(
            builder: (context, state) {
              debugPrint(state.toString());
              if (state is ClassesListInitial) {
                context.read<ClassesListBloc>().add(ClassesListOnAppear());
              }
              if (state is ClassesListPopToRoot) {
                debugPrint('ClassesListPopToRoot');
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
                context.read<ClassesListBloc>().add(ClassesListOnAppear());
              }
              if (state is ClassesListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ClassesListError) {
                showAlertDialog(context, state.message);
              }
              if (state is ClassesListShowAddTrackedTest) {
                showAddTrackedTestAlert(context);
              }
              if (state is ClassesListShowTrackedTest) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TestPage(
                          test: state.test,
                          trackedTestId: state.trackedTestId,
                        );
                      },
                    ),
                  ).then((value) {
                    context.read<ClassesListBloc>().add(ClassesListOnAppear());
                  });
                });
              }
              if (state is ClassesListShowSubjects) {
                Future.delayed(
                  Duration.zero,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SubjectsListPage(
                              schoolClass: state.schoolClass);
                        },
                      ),
                    ).then((value) {
                      debugPrint('returned');
                      context
                          .read<ClassesListBloc>()
                          .add(ClassesListOnAppear());
                    });
                  },
                );
              }
              if (state is ClassesListLoaded) {
                classes = state.classes;
              }
              return Builder(
                builder: (context) {
                  if (classes.isEmpty && state is ClassesListLoaded) {
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
                                  .read<ClassesListBloc>()
                                  .add(ClassesListOnAppear());
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
                                Expanded(
                                  child: Text(
                                    classes[index].name ?? '',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                  ),
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
