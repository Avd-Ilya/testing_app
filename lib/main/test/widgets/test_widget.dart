import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/test/bloc/test_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var selectedQuestion = 0;

  Widget _buildSelectionList(BuildContext context, TestState state) {
    return Container(
      // height: 400,
      // color: Colors.grey,
      margin: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        // primary: false,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildComparsionView(BuildContext context, TestState state) {
    return Container(
      // height: 400,
      // color: Colors.grey,
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
                      height: 50,
                    ),
                    Container(
                      height: 70,
                      color: Colors.grey,
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
      // height: 400,
      // color: Colors.grey,
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
                      height: 50,
                    ),
                    Container(
                      height: 70,
                      color: Colors.grey,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестирование'),
      ),
      body: SafeArea(
        // color: Colors.white,
        child: BlocBuilder<TestBloc, TestState>(
          builder: (context, state) {
            if (state is TestInitial) {
              context.read<TestBloc>().add(TestOnAppear());
            }
            if (state is TestUpdated) {
              selectedQuestion = state.selectedQuestion;
              debugPrint('${state.selectedAnswerOptions}');
              debugPrint('${state.coparsionAnswerOptions}');
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
                            color: index == selectedQuestion
                                ? Colors.lightBlue
                                : Colors.blueGrey,
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Icon(Icons.done),
                                ),
                                Text('${index + 1}')
                              ],
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
                          return _buildSelectionList(context, state);
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

class SelectionRow extends StatelessWidget {
  String text;
  bool isSelected;
  SelectionRow({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}

class ComparsionRow extends StatelessWidget {
  final String text;
  const ComparsionRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
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
                      text,
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
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return DottedBorder(
                  radius: const Radius.circular(10),
                  padding: const EdgeInsets.all(5),
                  child: const Center(child: Icon(Icons.add)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ComparsionElement extends StatelessWidget {
  final int id;
  final String text;
  const ComparsionElement({super.key, required this.id, required this.text});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: id,
      childWhenDragging: Container(),
      feedback: ComparsionTextView(text: text),
      child: ComparsionTextView(text: text),
    );
  }
}

class ComparsionTextView extends StatelessWidget {
  final String text;
  const ComparsionTextView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
