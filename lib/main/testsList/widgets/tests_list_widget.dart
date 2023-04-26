import 'package:core/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/main/test/page/test_page.dart';
import 'package:testing_app/main/testsList/bloc/tests_list_bloc.dart';

class TestsListWidget extends StatefulWidget {
  const TestsListWidget({super.key});

  @override
  State<TestsListWidget> createState() => _TestsListWidgetState();
}

class _TestsListWidgetState extends State<TestsListWidget> {
  List<TestDto> tests = [];

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
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            tests[index].topic ?? '',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
