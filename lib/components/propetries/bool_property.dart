import 'package:flutter/material.dart';

import '../../repository/data_transfer_object.dart';

class BoolProperty extends StatefulWidget{
  final Widget? leading;
  final String? title;
  final DataTransferObject object;
  final String field;

  const BoolProperty({super.key,
    this.leading,
    this.title,
    required this.object,
    required this.field});

  @override
  State<StatefulWidget> createState() {
    return _BoolPropertyState();
  }

}

class _BoolPropertyState extends State<BoolProperty>{
  void updateObject(bool? value) {
    setState(() {
      widget.object.set(widget.field, value as Object);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.black12,
            border: Border(
                bottom: BorderSide(color: Colors.black26, width: 2.0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 70, height: 70, child: widget.leading),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(value: widget.object.get(widget.field), onChanged: updateObject),
                Text(widget.title ?? ''),
              ],
            )
          ],
        ));
  }

}