import 'package:core/alert_dialog.dart';
import 'package:core/color_constants.dart';
import 'package:core/color_for_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/profile/activity_tracked_tests/bloc/activity_tracked_tests_bloc.dart';
import 'package:bmprogresshud/bmprogresshud.dart';

class ActivityTrackedTestsWidget extends StatefulWidget {
  const ActivityTrackedTestsWidget({super.key});

  @override
  State<ActivityTrackedTestsWidget> createState() =>
      _ActivityTrackedTestsWidgetState();
}

class _ActivityTrackedTestsWidgetState
    extends State<ActivityTrackedTestsWidget> {
  String dateToString(DateTime date) {
    var newFormat = DateFormat('dd.MM.yyyy HH:mm');
    return newFormat.format(date);
  }

  void copyKey(String key) async {
    await Clipboard.setData(ClipboardData(text: key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Активность'),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () {
              context
                  .read<ActivityTrackedTestsBloc>()
                  .add(ActivityTrackedTestsCopyButtonTapped());
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child:
              BlocBuilder<ActivityTrackedTestsBloc, ActivityTrackedTestsState>(
            builder: (context, state) {
              if (state is ActivityTrackedTestsInitial) {
                context
                    .read<ActivityTrackedTestsBloc>()
                    .add(ActivityTrackedTestsOnAppear());
              }
              if (state is ActivityTrackedTestsLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ActivityTrackedTestsError) {
                showAlertDialog(context, state.message);
              }
              if (state is ActivityTrackedTestsLoaded) {}
              if (state is ActivityTrackedTestsCopyKey) {
                copyKey(state.key);
                Future.delayed(Duration.zero, () {
                  ProgressHud.of(context)
                      ?.showSuccessAndDismiss(text: 'Ссылка на тест скопирована!');
                });
              }
              return Builder(
                builder: (context) {
                  if (state.activityTrackedTests.isEmpty) {
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
                                  .read<ActivityTrackedTestsBloc>()
                                  .add(ActivityTrackedTestsOnAppear());
                            },
                            child: const Text('Попробовать снова')),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: state.activityTrackedTests.length,
                      // separatorBuilder: (context, index) {
                      //   return const Divider(
                      //     // color: Colors.black,
                      //     endIndent: 15,
                      //     indent: 20,
                      //     thickness: 1,
                      //     height: 5,
                      //   );
                      // },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // context
                            //     .read<ResultsListBloc>()
                            //     .add(ResultsListSelected(index));
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
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.grey[350],
                                      width: 50,
                                      height: 50,
                                      child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBGwlAahaapmmJ7Riv_L_ZujOcfWSUJnm71g&usqp=CAU'),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  state
                                                          .activityTrackedTests[
                                                              index]
                                                          .user
                                                          ?.fio ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              // const Expanded(child: SizedBox()),
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
                                                              .activityTrackedTests[
                                                                  index]
                                                              .date ??
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  state
                                                          .activityTrackedTests[
                                                              index]
                                                          .user
                                                          ?.username ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${state.activityTrackedTests[index].result}%',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: colorForResult(state
                                                          .activityTrackedTests[
                                                              index]
                                                          .result ??
                                                      0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
