import 'package:flutter/material.dart';

class ComparsionTextView extends StatelessWidget {
  final String text;
  final Color color;
  const ComparsionTextView({super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
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
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}