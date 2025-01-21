import 'package:flutter/material.dart';
import 'package:meal_planner/menu/menu_service.dart';

import '../../custom_icons_icons.dart';
import '../../initializer.dart';
import '../propetries/text_property_edit.dart';
import '../../menu/menu.dart';

class AddMenuFab extends StatelessWidget{
  const AddMenuFab({super.key});

  get menuService => getIt.get<MenuService>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      child: const Icon(CustomIcons.plus),
      onPressed: () async {
        var res = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TextPropertyEditor(
                  fields: {"name": "", "note": ""},
                )));

         if (res["name"] != "") {
              menuService.saveMenu(Menu.fromMap(res));
            }
      },
    );
  }

}