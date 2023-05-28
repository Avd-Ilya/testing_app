import 'package:core/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/model/answer_option_dto.dart';
import 'package:testing_app/main/service/model/selected_option_dto.dart';
import 'package:testing_app/main/test/widgets/comparsion_element_widget.dart';
import 'package:testing_app/main/test/widgets/selection_row_widget.dart';
import 'package:testing_app/results/results/bloc/results_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key});

  Widget _buildSingleSelectionList(BuildContext context, ResultsState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.passedTest.test?.questions[state.selectedQuestion]
                ?.answerOptions?.length ??
            0,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // context.read<TestBloc>().add(TestSelectedAnswerOption(index));
            },
            child: SelectionRow(
              text: state.passedTest.test?.questions[state.selectedQuestion]
                      ?.answerOptions?[index].text ??
                  '',
              color: colorForRow(state, index),
              isSelected: state
                          .passedTest
                          .test
                          ?.questions[state.selectedQuestion]
                          ?.answerOptions?[index]
                          .id ==
                      state.passedTest.userAnswers?[state.selectedQuestion]
                          .selectedOptions?.firstOrNull?.answerOtion?.id
                  ? true
                  : false,
              isSingleSelection: true,
            ),
          );
        },
      ),
    );
  }

  Color colorForRow(ResultsState state, int index) {
    if (state.passedTest.test?.questions[state.selectedQuestion]
            ?.answerOptions?[index].id ==
        state.passedTest.userAnswers?[state.selectedQuestion].selectedOptions
            ?.firstOrNull?.answerOtion?.id) {
      if (state.passedTest.userAnswers?[state.selectedQuestion].selectedOptions
              ?.firstOrNull?.answerOtion?.isCorrect ??
          false) {
        return ColorConstants.greenBasic;
      } else {
        return ColorConstants.red;
      }
    }
    if (state.passedTest.test?.questions[state.selectedQuestion]
            ?.answerOptions?[index].isCorrect ??
        false) {
      return ColorConstants.greenBasic;
    }
    return Colors.white;
  }

  Color colorForSelectionRow(ResultsState state, int index) {
    var answerOptions =
        state.passedTest.test?.questions[state.selectedQuestion]?.answerOptions;
    var selectedOptions =
        state.passedTest.userAnswers?[state.selectedQuestion].selectedOptions;
    if (selectedOptions
            ?.firstWhere(
                (element) => element.answerOtionId == answerOptions?[index].id,
                orElse: () => SelectedOptionDto())
            .id !=
        null) {
      if (answerOptions?[index].isCorrect ?? false) {
        return ColorConstants.greenBasic;
      } else {
        return ColorConstants.red;
      }
    }
    if (state.passedTest.test?.questions[state.selectedQuestion]
            ?.answerOptions?[index].isCorrect ??
        false) {
      return ColorConstants.greenBasic;
    }
    return Colors.white;
  }

  Widget _buildSelectionList(BuildContext context, ResultsState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.passedTest.test?.questions[state.selectedQuestion]
                ?.answerOptions?.length ??
            0,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // context.read<TestBloc>().add(TestSelectedAnswerOption(index));
            },
            child: SelectionRow(
              text: state.passedTest.test?.questions[state.selectedQuestion]
                      ?.answerOptions?[index].text ??
                  '',
              isSelected: state.passedTest.userAnswers?[state.selectedQuestion]
                      .selectedOptions!
                      .firstWhere(
                          (element) =>
                              element.answerOtionId ==
                              state
                                  .passedTest
                                  .test
                                  ?.questions[state.selectedQuestion]
                                  ?.answerOptions?[index]
                                  .id,
                          orElse: () => SelectedOptionDto())
                      .id !=
                  null,
              // isSelected: false,
              isSingleSelection: false,
              color: colorForSelectionRow(state, index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildComparsionView(BuildContext context, ResultsState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.passedTest.test?.questions[state.selectedQuestion]
                    ?.answerOptions
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
                                state
                                        .passedTest
                                        .test
                                        ?.questions[state.selectedQuestion]
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
                        child: Builder(
                          builder: (context) {
                            if (state
                                    .passedTest
                                    .userAnswers?[state.selectedQuestion]
                                    .selectedOptions?[index]
                                    .answerOtion !=
                                null) {
                              var id = -1;
                              // var text = '123';
                              var text = state
                                      .passedTest
                                      .userAnswers?[state.selectedQuestion]
                                      .selectedOptions?[index]
                                      .answerOtion
                                      ?.text ??
                                  '123';
                              var leftOptions = state
                                  .passedTest
                                  .test
                                  ?.questions[state.selectedQuestion]
                                  ?.answerOptions
                                  ?.where(
                                (element) {
                                  return element.leftOptionId == null;
                                },
                              ).toList();
                              var color = ColorConstants.red;
                              if (state
                                      .passedTest
                                      .userAnswers?[state.selectedQuestion]
                                      .selectedOptions?[index]
                                      .answerOtion
                                      ?.leftOptionId ==
                                  leftOptions?[index].id) {
                                color = ColorConstants.greenBasic;
                              }
                              return ComparsionElement(
                                id: id,
                                text: text,
                                color: color,
                                isDraggable: false,
                              );
                            } else {
                              return DottedBorder(
                                radius: const Radius.circular(10),
                                padding: const EdgeInsets.all(5),
                                child: const Center(child: Icon(Icons.add)),
                              );
                            }
                          },
                        ))
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              List<AnswerOptionDto> unselectedOptions = [];
              var selectedOptions = state.passedTest
                  .userAnswers?[state.selectedQuestion].selectedOptions
                  ?.where((element) => element.answerOtion != null)
                  .toList();
              var rightOptions = state.passedTest.test
                  ?.questions[state.selectedQuestion]?.answerOptions
                  ?.where(
                (element) {
                  return element.leftOptionId != null;
                },
              ).toList();

              for (AnswerOptionDto rightOption in rightOptions ?? []) {
                var containt = false;
                for (SelectedOptionDto selectedOption
                    in selectedOptions ?? []) {
                  if (rightOption.id == selectedOption.answerOtionId) {
                    containt = true;
                  }
                }
                if (!containt) {
                  unselectedOptions.add(rightOption);
                }
              }
              if (unselectedOptions.isEmpty) {
                return Container();
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: unselectedOptions.length,
                        itemBuilder: (context, index) {
                          //         -1;
                          var text = unselectedOptions[index].text ?? 'error';
                          return ComparsionElement(
                            id: -1,
                            text: text,
                            isDraggable: false,
                          );
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

  Widget _buildSequenceView(BuildContext context, ResultsState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.passedTest.test?.questions[state.selectedQuestion]
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
                child: Builder(
                  builder: (context) {
                    var selectedOption = state.passedTest
                        .userAnswers?[state.selectedQuestion].selectedOptions
                        ?.firstWhere((element) => element.position == index,
                            orElse: () => SelectedOptionDto());
                    if (selectedOption?.answerOtion != null) {
                      var id = selectedOption?.id ?? -1;
                      var text = selectedOption?.answerOtion?.text ?? '';
                      var color = ColorConstants.red;
                      if (selectedOption?.position ==
                          selectedOption?.answerOtion?.position) {
                        color = ColorConstants.greenBasic;
                      }
                      return ComparsionElement(
                        isDraggable: false,
                        id: id,
                        text: text,
                        color: color,
                      );
                    } else {
                      return DottedBorder(
                        radius: const Radius.circular(10),
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.add)),
                      );
                    }
                  },
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              var unselectedOptions = state.passedTest
                  .userAnswers?[state.selectedQuestion].selectedOptions
                  ?.where((element) => element.answerOtion == null)
                  .toList();
              if (unselectedOptions == null || unselectedOptions.isEmpty) {
                return Container();
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: unselectedOptions.length,
                        itemBuilder: (context, index) {
                          return ComparsionElement(
                            isDraggable: false,
                            id: -1,
                            text: state
                                    .passedTest
                                    .userAnswers?[state.selectedQuestion]
                                    .question
                                    ?.answerOptions
                                    ?.firstWhere(
                                      (element) =>
                                          element.position ==
                                          unselectedOptions[index].position,
                                      orElse: () => AnswerOptionDto(),
                                    )
                                    .text ??
                                'error',
                          );
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

  Color colorForQuestion(ResultsState state, int index) {
    switch (state.passedTest.test?.questions[index]?.questionTypeId) {
      case 1:
        if (state.passedTest.userAnswers?[index].selectedOptions?.firstOrNull
                ?.answerOtion?.isCorrect ??
            false) {
          return ColorConstants.greenBasic;
        } else {
          return ColorConstants.red;
        }
      case 2:
        var answerOptions =
            state.passedTest.test?.questions[index]?.answerOptions;
        var selectedOptions =
            state.passedTest.userAnswers?[index].selectedOptions;
        double interimScore = 0;
        var quantityCorrectAnswers = 0;
        for (AnswerOptionDto answerOption in answerOptions ?? []) {
          if (answerOption.isCorrect ?? false) {
            quantityCorrectAnswers += 1;
          }
        }
        for (SelectedOptionDto selectedOption in selectedOptions ?? []) {
          if (selectedOption.answerOtion?.isCorrect ?? false) {
            interimScore += 1.0 / quantityCorrectAnswers;
          } else {
            interimScore = -1;
          }
        }
        if (interimScore > 0) {
          if (interimScore == 1) {
            return ColorConstants.greenBasic;
          } else {
            return ColorConstants.yellow;
          }
        } else {
          return ColorConstants.red;
        }
      case 3:
        var leftOptions =
            state.passedTest.test?.questions[index]?.answerOptions?.where(
          (element) {
            return element.leftOptionId == null;
          },
        ).toList();
        var count =
            state.passedTest.userAnswers?[index].selectedOptions?.length ?? 0;
        var score = 0;
        for (SelectedOptionDto selectedOption
            in state.passedTest.userAnswers![index].selectedOptions ?? []) {
          if (selectedOption.answerOtion?.leftOptionId ==
              leftOptions?[selectedOption.position].id) {
            score += 1;
          }
        }
        if (score == 0) {
          return ColorConstants.red;
        }
        if (score == count) {
          return ColorConstants.greenBasic;
        } else {
          return ColorConstants.yellow;
        }
      case 4:
        var count =
            state.passedTest.userAnswers?[index].selectedOptions?.length ?? 0;
        var score = 0;
        for (SelectedOptionDto selectedOption
            in state.passedTest.userAnswers![index].selectedOptions ?? []) {
          if (selectedOption.position == selectedOption.answerOtion?.position) {
            score += 1;
          }
        }
        if (score == 0) {
          return ColorConstants.red;
        }
        if (score == count) {
          return ColorConstants.greenBasic;
        } else {
          return ColorConstants.yellow;
        }
      default:
    }

    return Colors.blue;
  }

  void showFinishAlert(BuildContext context) {
    CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
      title: const Text("Завершить просмотр?"),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            context.read<ResultsBloc>().add(ResultsOnAppear());
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
            context.read<ResultsBloc>().add(ResultsFinishAccepted());
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
        title: const Text('Пройденный тест'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ResultsBloc, ResultsState>(
            builder: (context, state) {
              if (state is ResultsShouldFinish) {
                showFinishAlert(context);
              }
              if (state is ResultsClose) {
                Future.delayed(
                  Duration.zero,
                  () {
                    Navigator.of(context).pop();
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
                        itemCount: state.passedTest.test?.questions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ResultsBloc>()
                                  .add(ResultsSelectedQuestion(index));
                            },
                            child: Container(
                              width: 70,
                              margin: const EdgeInsets.all(5),
                              color: colorForQuestion(state, index),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      // color: ColorConstants.darkBlue,
                                      color: index == state.selectedQuestion
                                          ? Colors.black
                                          : colorForQuestion(state, index),
                                    ),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Center(child: Text('${index + 1}')),
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
                        '${state.selectedQuestion + 1}. ${state.passedTest.test?.questions[state.selectedQuestion]?.task ?? ''}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        switch (state
                            .passedTest
                            .test
                            ?.questions[state.selectedQuestion]
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
                          context.read<ResultsBloc>().add(ResultsNextTapped());
                        },
                        child: Builder(
                          builder: (context) {
                            if (state.passedTest.test?.questions.length ==
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
      ),
    );
  }
}
