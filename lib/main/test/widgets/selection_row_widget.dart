import 'package:flutter/material.dart';

class SelectionRow extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isSingleSelection;
  final Color color;
  const SelectionRow(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.isSingleSelection,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 70,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Row(
          children: [
            Builder(
              builder: (context) {
                if (isSingleSelection) {
                  if (isSelected) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.done),
                    );
                  } else {
                    return const SizedBox(width: 40);
                  }
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                  );
                }
              },
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
