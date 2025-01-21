import 'package:flutter/material.dart';
import 'package:meal_planner/components/BottomApplicationBar/bottom_application_bar_padding_item.dart';

import 'bottom_application_bar_card.dart';

class BottomApplicationBar extends StatelessWidget {
  const BottomApplicationBar(
      {super.key, required this.items, required this.onTap});

  final List<Widget> items;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    int index = 0;
    for (final item in items) {
      if (item is BottomApplicationBarPaddingItem) {
        children.add(item);
      }

      children.add(
          BottomApplicationBarCard(item: item, index: index, onTap: onTap));
      index = index + 1;
    }

    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ));
  }
}
