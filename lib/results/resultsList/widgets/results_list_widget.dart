import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsListWidget extends StatelessWidget {
  const ResultsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Результаты"),
      ),
      body: Container(),
    );
  }
}
