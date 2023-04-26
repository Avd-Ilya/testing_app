import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String errorMessage) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(); // dismiss dialog
    },
  );

  CupertinoAlertDialog cupertinoAlert = CupertinoAlertDialog(
    title: const Text("Ошибка!"),
    content: Text(errorMessage),
    actions: [
      okButton,
    ],
  );

  // show the dialog
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
