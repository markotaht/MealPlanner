import 'package:flutter/material.dart';

class BottomApplicationBarCard extends StatelessWidget{
  const BottomApplicationBarCard({super.key, required this.item, required this.index, required this.onTap});

  final Widget item;
  final int index;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: item,
      onTap: () => {onTap(index)},
    );
  }

}