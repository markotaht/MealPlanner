import 'package:flutter/material.dart';
import 'package:meal_planner/repository/data_transfer_object.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ListProperty extends StatefulWidget {
  final Widget? leading;
  final String? title;
  final DataTransferObject object;
  final String field;

  const ListProperty(
      {super.key,
      this.leading,
      this.title,
      required this.object,
      required this.field});

  @override
  State<StatefulWidget> createState() {
    return _ListPropertyState();
  }
}

class _ListPropertyState extends State<ListProperty> {
  bool _editMode = false;
  final _stringTagController = StringTagController();

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    categories = widget.object.get(widget.field);
  }

  void updateObject(String value) {
    setState(() {
      _editMode = false;
      widget.object.set(widget.field, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(categories.toString());
    return GestureDetector(
        onTap: () {
          setState(() {
            _editMode = true;
          });
        },
        child: Container(
            height: 70,
            decoration: const BoxDecoration(
                color: Colors.black12,
                border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 2.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 70, height: 70, child: widget.leading),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: !_editMode
                      ? ([
                          Text(widget.title ?? ''),
                          Text(categories.toString())
                        ])
                      : ([
                          IntrinsicWidth(
                              stepWidth: 200,
                              child: TextFieldTags<String>(
                                textfieldTagsController: _stringTagController,
                                initialTags: const ['categories'],
                                textSeparators: const [' ', ','],
                                inputFieldBuilder: (context, inputFieldValues) {
                                  return TextField(
                                    controller:
                                        inputFieldValues.textEditingController,
                                    focusNode: inputFieldValues.focusNode,
                                    onSubmitted: inputFieldValues.onTagSubmitted,
                                  );
                                },
                              ))
                        ]),
                )
              ],
            )));
  }
}
