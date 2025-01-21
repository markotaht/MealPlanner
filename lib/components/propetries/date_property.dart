import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repository/data_transfer_object.dart';

class DateProperty extends StatefulWidget {
  final Widget? leading;
  final String? title;
  final DataTransferObject object;
  final String field;
  final String format;

  const DateProperty(
      {super.key,
      this.leading,
      this.title,
      required this.object,
      required this.field,
      this.format = 'yyyy-MM-dd'});

  @override
  State<StatefulWidget> createState() {
    return _DatePropertyState();
  }
}

class _DatePropertyState extends State<DateProperty> {

  String formatDate(DateTime? date){
    if(date == null){
      return '';
    }
    return DateFormat(widget.format).format(date);
  }

  void updateObject(DateTime value) {
    setState(() {
      widget.object.set(widget.field, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            updateObject(pickedDate);
          }
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
                  children: [
                    Text(widget.title ?? ''),
                    Text(formatDate(widget.object.get(widget.field)))
                  ],
                )
              ],
            )));
  }
}
