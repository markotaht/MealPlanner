import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'custom_icons_icons.dart';

final getIt = GetIt.instance;

class ListHeader extends StatefulWidget {
  const ListHeader(
      {super.key,
      required this.onShowButtonClick,
      required this.onSubmitAddItem});

  final void Function() onShowButtonClick;
  final void Function(String name) onSubmitAddItem;

  @override
  State<StatefulWidget> createState() {
    return _ListHeaderState();
  }
}

class _ListHeaderState extends State<ListHeader> {
  bool addItemMode = false;
  bool showHidden = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: addItemMode
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  onTapOutside: (e) {
                    setState(() {
                      addItemMode = false;
                    });
                  },
                  onSubmitted: (e) {
                    if (_controller.text.isNotEmpty) {
                      widget.onSubmitAddItem(_controller.text);
                    }
                    setState(() {
                      addItemMode = false;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                ))
            : Row(children: [
                TextButton(
                    style: ButtonStyle(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(0)),
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        shape: MaterialStateProperty.all<
                                ContinuousRectangleBorder>(
                            const ContinuousRectangleBorder())),
                    onPressed: () {
                      setState(() {
                        addItemMode = true;
                      });
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(CustomIcons.plus), Text("Add Item")])),
                IconButton(
                    style: ButtonStyle(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(0)),
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        shape: MaterialStateProperty.all<
                                ContinuousRectangleBorder>(
                            const ContinuousRectangleBorder())),
                    onPressed: () {
                      widget.onShowButtonClick();
                      setState(() {
                        showHidden = !showHidden;
                      });
                    },
                    icon: Icon(
                        showHidden ? CustomIcons.eye_off : CustomIcons.eye)),
              ]));
  }
}
