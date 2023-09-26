import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/complitedTest/page/complited_test_page.dart';
import 'package:testing_app/main/test/bloc/test_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:testing_app/main/test/widgets/comparsion_element_widget.dart';
import 'package:testing_app/main/test/widgets/selection_row_widget.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var selectedQuestion = 0;

  Widget _buildSingleSelectionList(BuildContext context, TestState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.test.questions[state.selectedQuestion]?.answerOptions
                ?.length ??
            0,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<TestBloc>().add(TestSelectedAnswerOption(index));
            },
            child: SelectionRow(
              text: state.test.questions[state.selectedQuestion]
                      ?.answerOptions?[index].text ??
                  '',
              isSelected: state is TestInitial
                  ? false
                  : state.selectedAnswerOptions[state.selectedQuestion]
                      .contains(index),
              isSingleSelection: true,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectionList(BuildContext context, TestState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.test.questions[state.selectedQuestion]?.answerOptions
                ?.length ??
            0,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<TestBloc>().add(TestSelectedAnswerOption(index));
            },
            child: SelectionRow(
              text: state.test.questions[state.selectedQuestion]
                      ?.answerOptions?[index].text ??
                  '',
              isSelected: state is TestInitial
                  ? false
                  : state.selectedAnswerOptions[state.selectedQuestion]
                      .contains(index),
              isSingleSelection: false,
            ),
          );
        },
      ),
    );
  }

  Widget _buildComparsionView(BuildContext context, TestState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state
                    .test.questions[state.selectedQuestion]?.answerOptions
                    ?.where(
                  (element) {
                    return element.leftOptionId == null;
                  },
                ).length ??
                0,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                state.test.questions[state.selectedQuestion]
                                        ?.answerOptions
                                        ?.where((element) {
                                          return element.leftOptionId == null;
                                        })
                                        .toList()[index]
                                        .text ??
                                    '',
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          if (state.selectedAnswerOptions[selectedQuestion]
                                  [index] !=
                              null) {
                            var id =
                                state.selectedAnswerOptions[selectedQuestion]
                                        [index] ??
                                    -1;
                            var text = state.test.questions[selectedQuestion]
                                    ?.answerOptions
                                    ?.where((element) {
                                      return element.id == id;
                                    })
                                    .first
                                    .text ??
                                '';
                            return ComparsionElement(id: id, text: text);
                          } else {
                            return DottedBorder(
                              radius: const Radius.circular(10),
                              padding: const EdgeInsets.all(5),
                              child: const Center(child: Icon(Icons.add)),
                            );
                          }
                        },
                        onWillAccept: (data) {
                          return data != null;
                        },
                        onAccept: (data) {
                          debugPrint('onAccept - $data');
                          context.read<TestBloc>().add(
                              TestSelectedAnswerOption.withId(index, data));
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              if (state
                  .coparsionAnswerOptions[state.selectedQuestion].isEmpty) {
                return Container();
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 70,
                      // color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .coparsionAnswerOptions[state.selectedQuestion]
                            .length,
                        itemBuilder: (context, index) {
                          return ComparsionElement(
                              id: state.coparsionAnswerOptions[
                                      state.selectedQuestion][index] ??
                                  -1,
                              text: state.test.questions[state.selectedQuestion]
                                      ?.answerOptions
                                      ?.where((element) {
                                        return element.id ==
                                            state.coparsionAnswerOptions[
                                                state.selectedQuestion][index];
                                      })
                                      .first
                                      .text ??
                                  '');
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSequenceView(BuildContext context, TestState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.test.questions[state.selectedQuestion]
                    ?.answerOptions?.length ??
                0,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return SizedBox(
                height: 70,
                child: DragTarget<int>(
                  builder: (context, candidateData, rejectedData) {
                    if (state.selectedAnswerOptions[selectedQuestion][index] !=
                        null) {
                      var id = state.selectedAnswerOptions[selectedQuestion]
                              [index] ??
                          -1;
                      var text =
                          state.test.questions[selectedQuestion]?.answerOptions
                                  ?.where((element) {
                                    return element.id == id;
                                  })
                                  .first
                                  .text ??
                              '';
                      return ComparsionElement(id: id, text: text);
                    } else {
                      return DottedBorder(
                        radius: const Radius.circular(10),
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.add)),
                      );
                    }
                  },
                  onWillAccept: (data) {
                    return data != null;
                  },
                  onAccept: (data) {
                    context
                        .read<TestBloc>()
                        .add(TestSelectedAnswerOption.withId(index, data));
                  },
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              if (state
                  .coparsionAnswerOptions[state.selectedQuestion].isEmpty) {
                return Container();
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 70,
                      // color: Colors.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .coparsionAnswerOptions[state.selectedQuestion]
                            .length,
                        itemBuilder: (context, index) {
                          return ComparsionElement(
                              id: state.coparsionAnswerOptions[
                                      state.selectedQuestion][index] ??
                                  -1,
                              text: state.test.questions[state.selectedQuestion]
                                      ?.answerOptions
                                      ?.where((element) {
                                        return element.id ==
                                            state.coparsionAnswerOptions[
                                                state.selectedQuestion][index];
                                      })
                                      .first
                                      .text ??
                                  '');
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void showFinishAlert(BuildContext context) {
    CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
      title: const Text("Завершить тестирование?"),
      content: const Text(
          'Тестирование будет завершено. Результаты будут отправлены.'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text(
            'Нет',
            style: TextStyle(color: Colors.green),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            context.read<TestBloc>().add(TestFinishAccepted());
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Да'),
        ),
      ],
    );

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Тестирование'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TestBloc>().add(TestSendTapped());
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: SafeArea(
        // color: Colors.white,
        child: BlocBuilder<TestBloc, TestState>(
          builder: (context, state) {
            if (state is TestInitial) {
              context.read<TestBloc>().add(TestOnAppear());
              context.read<TestBloc>().add(const TestSelectedQuestion(0));
            }
            if (state is TestUpdated) {
              selectedQuestion = state.selectedQuestion;
              debugPrint('${state.selectedAnswerOptions}');
              // debugPrint('${state.coparsionAnswerOptions}');
            }
            if (state is TestShouldFinish) {
              showFinishAlert(context);
            }
            if (state is TestLoading) {
              // return const CircularProgressIndicator();
              ProgressHud.showLoading();
            } else {
              ProgressHud.dismiss();
            }
            if (state is TestError) {
              showAlertDialog(context, state.message);
            }
            if (state is TestCompleted) {
              Future.delayed(
                Duration.zero,
                () {
                  ProgressHud.of(context)
                      ?.showSuccessAndDismiss(text: 'Тест отправлен!')
                      .then((value) {
                    Future.delayed(Duration.zero, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ComplitedTestPage(result: state.result);
                          },
                        ),
                      );
                    });
                  });
                },
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 70,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.test.questions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<TestBloc>()
                                .add(TestSelectedQuestion(index));
                          },
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.all(5),
                            // color: index == selectedQuestion
                            //     ? ColorConstants.blue
                            //     : ColorConstants.lightGray,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: index == selectedQuestion
                                        ? ColorConstants.blue
                                        : ColorConstants.lightGray,
                                  ),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Builder(
                                      builder: (context) {
                                        Widget child =
                                            const Icon(Icons.minimize);
                                        if (state is! TestInitial) {
                                          switch (state.test.questions[index]
                                              ?.questionTypeId) {
                                            case 1:
                                              if (state
                                                  .selectedAnswerOptions[index]
                                                  .isNotEmpty) {
                                                child = const Icon(Icons.done);
                                              } else {
                                                child =
                                                    const Icon(Icons.minimize);
                                              }
                                              break;
                                            case 2:
                                              if (state
                                                  .selectedAnswerOptions[index]
                                                  .isNotEmpty) {
                                                child = const Icon(Icons.done);
                                              } else {
                                                child =
                                                    const Icon(Icons.minimize);
                                              }
                                              break;
                                            case 3:
                                              if (state
                                                  .coparsionAnswerOptions[index]
                                                  .isEmpty) {
                                                child = const Icon(Icons.done);
                                              } else {
                                                child =
                                                    const Icon(Icons.minimize);
                                              }
                                              break;
                                            case 4:
                                              if (state
                                                  .coparsionAnswerOptions[index]
                                                  .isEmpty) {
                                                child = const Icon(Icons.done);
                                              } else {
                                                child =
                                                    const Icon(Icons.minimize);
                                              }
                                              break;
                                            default:
                                              break;
                                          }
                                        }
                                        return child;
                                      },
                                    ),
                                  ),
                                  Text('${index + 1}')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      textAlign: TextAlign.left,
                      '${state.selectedQuestion + 1}. ${state.test.questions[state.selectedQuestion]?.task ?? ''}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      switch (state.test.questions[state.selectedQuestion]
                          ?.questionTypeId) {
                        case 1:
                          return _buildSingleSelectionList(context, state);
                        case 2:
                          return _buildSelectionList(context, state);
                        case 3:
                          return _buildComparsionView(context, state);
                        case 4:
                          return _buildSequenceView(context, state);
                        default:
                      }
                      return Container();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorConstants.darkBlue),
                      ),
                      onPressed: () {
                        context.read<TestBloc>().add(TestNextTapped());
                      },
                      child: Builder(
                        builder: (context) {
                          if (state.test.questions.length ==
                              state.selectedQuestion + 1) {
                            return const Text('Завершить');
                          } else {
                            return const Text('Далее');
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
