import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

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
