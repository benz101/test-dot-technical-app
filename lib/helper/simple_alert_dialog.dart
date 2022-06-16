import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleAlertDialog {
  static showSimpleAlertDialog(BuildContext context, String content) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Pesan"),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ya')),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
