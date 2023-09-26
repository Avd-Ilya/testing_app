import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:core/color_for_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/results/results/page/results_page.dart';
import 'package:testing_app/results/resultsList/bloc/results_list_bloc.dart';
import 'package:intl/intl.dart';

class ResultsListWidget extends StatelessWidget {
  const ResultsListWidget({super.key});

  String dateToString(DateTime date) {
    var newFormat = DateFormat('dd.MM.yyyy HH:mm');
    return newFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Результаты"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ResultsListBloc, ResultsListState>(
            builder: (context, state) {
              if (state is ResultsListInitial) {
                context.read<ResultsListBloc>().add(ResultsListOnAppear());
              }
              if (state is ResultsListLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ResultsListError) {
                showAlertDialog(context, state.message);
              }
              if (state is ResultsListShowResults) {
                Future.delayed(
                  Duration.zero,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ResultsPage(passedTest: state.passedTest);
                      },
                    )).then((value) {
                      context
                          .read<ResultsListBloc>()
                          .add(ResultsListOnAppear());
                    });
                  },
                );
              }
              if (state is ResultsListLoaded) {}
              return Builder(
                builder: (context) {
                  if (state.passedTests.isEmpty && state is ResultsListLoaded) {
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
                                  .read<ResultsListBloc>()
                                  .add(ResultsListOnAppear());
                            },
                            child: const Text('Попробовать снова')),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: state.passedTests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<ResultsListBloc>()
                                .add(ResultsListSelected(index));
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                // color: Colors.grey[350],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    spreadRadius: 0.1,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state
                                                        .passedTests[index]
                                                        .test
                                                        ?.chapter
                                                        ?.subject
                                                        ?.name ??
                                                    '',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Expanded(child: SizedBox()),
                                              DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade400,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(7)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    dateToString(state
                                                            .passedTests[index]
                                                            .date ??
                                                        DateTime(0)),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                state.passedTests[index].test
                                                        ?.chapter?.name ??
                                                    '',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Expanded(child: SizedBox()),
                                              Text(
                                                '${state.passedTests[index].result}%',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorForResult(state
                                                          .passedTests[index]
                                                          .result ??
                                                      0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.passedTests[index].test
                                                    ?.topic ??
                                                '',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right),
                                  ],
                                ),
                              ),
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
