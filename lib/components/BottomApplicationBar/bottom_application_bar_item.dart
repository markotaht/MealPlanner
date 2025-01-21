import 'package:flutter/cupertino.dart';

class BottomApplicationBarItem extends StatelessWidget{
  const BottomApplicationBarItem({super.key, required this.icon, this.label});

  final Widget icon;
  final String? label;
  @override
  Widget build(BuildContext context) {
    var children = [icon];
    if(label != null){
      children.add(Text(label as String));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,);
  }

}