import 'package:flutter/material.dart';
import 'package:meal_planner/repository/data_transfer_object.dart';

class TextProperty extends StatefulWidget {
  final Widget? leading;
  final String? title;
  final DataTransferObject object;
  final String field;

  const TextProperty(
      {super.key,
      this.leading,
      this.title,
      required this.object,
      required this.field});

  @override
  State<StatefulWidget> createState() {
    return _TextPropertyState();
  }
}

class _TextPropertyState extends State<TextProperty> {
  bool _editMode = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.object.get(widget.field));
  }

  void updateObject(String value) {
    setState(() {
      _editMode = false;
      widget.object.set(widget.field, value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          Text(widget.object.get(widget.field) ?? '')
                        ])
                      : [
                          IntrinsicWidth(
                              stepWidth: 100,
                              child: TextField(
                                autofocus: true,
                                controller: _controller,
                                onTapOutside: (e) {
                                  updateObject(_controller.text);
                                },
                                onSubmitted: updateObject,
                                decoration: InputDecoration(
                                    labelText: widget.title,
                                    border: InputBorder.none),
                              ))
                        ],
                )
              ],
            )));
  }
}
