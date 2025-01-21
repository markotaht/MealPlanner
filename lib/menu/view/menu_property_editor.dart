import 'package:flutter/material.dart';
import 'package:meal_planner/extensions/list_space_between_extension.dart';
import 'package:meal_planner/components/propetries/text_input_field.dart';

import '../menu.dart';

class MenuPropertyEditor extends StatefulWidget {
  const MenuPropertyEditor({super.key, required this.menu});

  final Menu menu;

  @override
  State<StatefulWidget> createState() {
    return _MenuPropertyEditorState();
  }
}

class _MenuPropertyEditorState extends State<MenuPropertyEditor> {
  late TextEditingController nameEditingController;
  late TextEditingController noteEditingController;

  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController(text: widget.menu.name);
    noteEditingController = TextEditingController(text: widget.menu.note);
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    noteEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      TextInputField(controller: nameEditingController, title: "Name"),
      TextInputField(controller: noteEditingController, title: "Note")
    ].withSpaceBetween(height: 10);

    return Scaffold(
        appBar: AppBar(
            title: const Text("Menu Properties"),
            leading: BackButton(onPressed: () {
              Map<String, String> results = {};
              results["name"] = nameEditingController.text;
              if(noteEditingController.text.isNotEmpty) {
                results["note"] = noteEditingController.text;
              }

              Navigator.pop(context, results);
            })),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: children,
            )));
  }
}
