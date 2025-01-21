import 'package:flutter/cupertino.dart';

extension ListSPaceBetweenExtension on List<Widget>{
  List<Widget> withSpaceBetween({double? width, double? height}) => [
    for (int i = 0; i < length; i++)
      ...[
        if (i > 0)
          SizedBox(width: width, height: height),
        this[i],
      ],
  ];
}