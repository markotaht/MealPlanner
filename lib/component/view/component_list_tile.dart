import 'package:flutter/material.dart';
import 'package:meal_planner/pages/component_page/component_page.dart';

import '../../custom_icons_icons.dart';
import '../component.dart';

class ComponentListTile extends StatelessWidget{
  const ComponentListTile({super.key, required this.index, required this.component});

  final Component component;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Widget> infoElements = [
      Text(
        component.name,
        style: Theme.of(context).textTheme.headlineSmall,
      )
    ];
    if (component.note != null) {
      infoElements.add(Text(component.note as String));
    }

    return Container(
        decoration: BoxDecoration(
          border: const Border(bottom: BorderSide(width: 2, color: Color(0xaaaaaaaa))),
          color: (index % 2 == 0) ? const Color(0x00000000) : const Color(0xdddddddd),
        ),
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComponentPage(component: component)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      CustomIcons.ingredients,
                      size: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: infoElements,
                  )
                ],
              ),
            )));
  }

}