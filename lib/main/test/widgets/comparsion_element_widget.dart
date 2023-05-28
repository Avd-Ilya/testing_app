import 'package:flutter/material.dart';
import 'package:testing_app/main/test/widgets/comparsion_text_view.dart';

class ComparsionElement extends StatelessWidget {
  final int id;
  final String text;
  final Color color;
  final bool isDraggable;
  const ComparsionElement(
      {super.key,
      required this.id,
      required this.text,
      this.color = Colors.white,
      this.isDraggable = true});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isDraggable) {
          return Draggable(
            data: id,
            childWhenDragging: Container(),
            feedback: ComparsionTextView(
              text: text,
              color: color,
            ),
            child: ComparsionTextView(
              text: text,
              color: color,
            ),
          );
        } else {
          return ComparsionTextView(
            text: text,
            color: color,
          );
        }
      },
    );
  }
}
