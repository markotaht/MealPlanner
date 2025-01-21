import 'package:flutter/material.dart';
import 'package:meal_planner/extensions/list_space_between_extension.dart';
import 'package:meal_planner/components/propetries/text_input_field.dart';

class TextPropertyEditor extends StatefulWidget {
  const TextPropertyEditor({super.key, required this.fields});

  final Map<String, String?> fields;

  @override
  State<StatefulWidget> createState() {
    return _TextPropertyEditorState();
  }
}

class _TextPropertyEditorState extends State<TextPropertyEditor> {
  late List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var entry in widget.fields.entries) {
      controllers.add(TextEditingController(text: entry.value));
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Property editor"),
        leading: ElevatedButton(
            onPressed: () {
              Map<String, String> results = {};
              for (var (index, entry) in widget.fields.entries.indexed) {
                results[entry.key] = controllers[index].text;
              }
              Navigator.pop(context, results);
            },
            child: const Text("Back")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: controllers.asMap().entries.map(
            (e) => TextInputField(controller: e.value,
            title: widget.fields.entries.toList()[e.key].key)).toList().withSpaceBetween(height: 10),
    )));
  }

}