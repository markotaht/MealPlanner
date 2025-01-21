import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';
import '../component.dart';
import '../../pages/component_page/component_page.dart';

class ComponentListItem extends StatelessWidget {
  const ComponentListItem({super.key, required this.component});

  final Component component;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(component.name),
                              Text(component.expirationDate.toString())
                            ]))))),
        SizedBox(
          height: 60,
          child: AspectRatio(
              aspectRatio: 1,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ComponentPage(component: component);
                    }));
                  },
                  icon: const Icon(CustomIcons.edit))),
        )
      ],
    );
  }
}
