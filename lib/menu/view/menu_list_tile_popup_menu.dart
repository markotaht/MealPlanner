import 'package:flutter/material.dart';
import 'package:meal_planner/initializer.dart';

import '../../delete_dialogue.dart';
import '../menu.dart';
import '../menu_service.dart';
import 'menu_property_editor.dart';

class MenuListTilePopupMenu {
  final MenuService menuService;

  MenuListTilePopupMenu() : menuService = getIt.get<MenuService>();

  RelativeRect calculatePopUpPosition(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final left = offset.dx + renderBox.size.width;
    final top = offset.dy + renderBox.size.height;
    return RelativeRect.fromLTRB(left, top, 0, 0);
  }

  void showPopupMenu(BuildContext context, Menu menu) async {
    await showMenu(
        context: context,
        position: calculatePopUpPosition(context),
        items: [
          PopupMenuItem(
            value: 1,
            child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuPropertyEditor(
                                menu: menu,
                              )));
                  menuService.saveMenu(menu.update(res));
                },
                child: const Text("Edit")),
          ),
          PopupMenuItem(
            value: 2,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDialogue(
                            text: "Are you sure you want to delete a menu",
                            onConfirm: () {
                              menuService.deleteMenu(menu);
                            });
                      });
                },
                child: const Text("Delete")),
          ),
        ]);
  }
}
