import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/profile/activity_tracked_tests/page/activity_tracked_tests_page.dart';
import 'package:testing_app/profile/trackedTestsList/bloc/tracked_tests_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackedTestsListWidget extends StatelessWidget {
  const TrackedTestsListWidget({super.key});

  String dateToString(DateTime date) {
    var newFormat = DateFormat('dd.MM.yyyy HH:mm');
    return newFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отслеживаемые тесты'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<TrackedTestsListBloc, TrackedTestsListState>(
            builder: (context, state) {
              if (state is TrackedTestsListInitial) {
                context
                    .read<TrackedTestsListBloc>()
                    .add(TrackedTestsListOnAppear());
              }
              if (state is TrackedTestsListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TrackedTestsListError) {
                showAlertDialog(context, state.message);
              }
              if (state is TrackedTestsListShowActivity) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ActivityTrackedTestsPage(
                          trackedTestId: state.tarckedTestId,
                          tarckedTestKey: state.tarckedTestKey,
                        );
                      },
                    ),
                  ).then((value) {
                    context
                        .read<TrackedTestsListBloc>()
                        .add(TrackedTestsListOnAppear());
                  });
                });
              }
              return Builder(
                builder: (context) {
                  if (state.trackedTests.isEmpty) {
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
                                  .read<TrackedTestsListBloc>()
                                  .add(TrackedTestsListOnAppear());
                            },
                            child: const Text('Попробовать снова')),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: state.trackedTests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<TrackedTestsListBloc>()
                                .add(TrackedTestsListSelected(index));
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
                                                        .trackedTests[index]
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
                                                              .trackedTests[
                                                                  index]
                                                              .dateCreation ??
                                                          DateTime(0)),
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.trackedTests[index].test
                                                    ?.chapter?.name ??
                                                '',
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.trackedTests[index].test
                                                    ?.topic ??
                                                '',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              if (state.trackedTests[index]
                                                          .description !=
                                                      null &&
                                                  state.trackedTests[index]
                                                          .description !=
                                                      '') {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      'Описание:',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      state.trackedTests[index]
                                                              .description ??
                                                          '',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right)
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
