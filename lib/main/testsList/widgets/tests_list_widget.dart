import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/main/test/page/test_page.dart';
import 'package:testing_app/main/testsList/bloc/tests_list_bloc.dart';
import 'package:flutter/services.dart';

class TestsListWidget extends StatefulWidget {
  const TestsListWidget({super.key});

  @override
  State<TestsListWidget> createState() => _TestsListWidgetState();
}

class _TestsListWidgetState extends State<TestsListWidget> {
  List<TestDto> tests = [];
  var _textFieldController = TextEditingController();

  void showCreateTrackedTestAlert(BuildContext context) {
    CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text("Описание теста"),
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
            // context
            //     .read<TestsListBloc>()
            //     .add(TestsListCreatingTrackedTestCancelled());
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Отменить'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            context
                .read<TestsListBloc>()
                .add(TestsListCreateTrackedTest(_textFieldController.text));
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text(
            'Создать',
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
              .read<TestsListBloc>()
              .add(TestsListCreatingTrackedTestCancelled());
        });
      },
    );
  }

  void showCreatedTrackedTestAlert(BuildContext context, String key) {
    CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
      title: const Text("Ссылка на тест создана!"),
      content: Text(key),
      actions: [
        CupertinoDialogAction(
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await Clipboard.setData(ClipboardData(text: key));
          },
          child: const Text(
            'Скопировать',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Готово'),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тесты'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<TestsListBloc, TestsListState>(
            builder: (context, state) {
              if (state is TestsListInitial) {
                context.read<TestsListBloc>().add(TestsListNeedData());
              }
              if (state is TestsListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is TestsListError) {
                showAlertDialog(context, state.message);
              }
              if (state is TestsListLoaded) {
                tests = state.tests;
              }
              if (state is TestsListShowTest) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TestPage(test: state.test);
                      },
                    ),
                  ).then((value) {
                    context.read<TestsListBloc>().add(TestsListNeedData());
                  });
                });
              }
              if (state is TestsListCreatingTrackedTest) {
                showCreateTrackedTestAlert(context);
              }
              if (state is TestsListTrackedTestCreated) {
                showCreatedTrackedTestAlert(context, state.key);
              }
              return Builder(
                builder: (context) {
                  if (tests.isEmpty && state is TestsListLoaded) {
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
                                  .read<TestsListBloc>()
                                  .add(TestsListNeedData());
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
                      itemCount: tests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<TestsListBloc>()
                                .add(TestsListSelected(index));
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tests[index].topic ?? '',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  color: Colors.grey[350],
                                  shadowColor: Colors.white60,
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  ),
                                  offset: const Offset(-10, 45),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            child: Text(
                                              'Создать ссылку на тест',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Icon(Icons.school)
                                        ],
                                      ),
                                    )
                                  ],
                                  onSelected: (value) {
                                    if (value == 1) {
                                      context.read<TestsListBloc>().add(
                                          TestsListShouldCreateTrackedTest(
                                              index));
                                    }
                                  },
                                ),
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
