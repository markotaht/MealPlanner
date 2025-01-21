import 'package:flutter/material.dart';

class DeleteDialogue extends StatelessWidget {
  const DeleteDialogue({super.key, required this.text, required this.onConfirm});

  final String text;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Confirmation Dialogue"),
        content: Text(text),
        actions: [
          TextButton(onPressed:(){
            Navigator.of(context).pop();
            onConfirm();
          }, child: const Text("Confirm")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          )
        ]);
  }
}
