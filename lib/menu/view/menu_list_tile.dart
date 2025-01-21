import 'package:flutter/material.dart';
import 'package:meal_planner/themes/extensions/alternating_list_tile_theme.dart';

import '../../custom_icons_icons.dart';
import '../../pages/menu_page/menu_page.dart';
import '../menu.dart';
import '../menu_service.dart';
import 'menu_list_tile_popup_menu.dart';

class MenuListTile extends StatelessWidget {
  MenuListTile(
      {super.key,
      required this.menu,
      required this.menuService,
      required this.index});

  final Menu menu;
  final MenuService menuService;
  final int index;
  final MenuListTilePopupMenu menuListTilePopupMenu = MenuListTilePopupMenu();

  void navigateToMenu(BuildContext context) async {
    Menu? fullMenu = await menuService.loadFullMenuItem(menu.id);
    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuPage(menu: fullMenu as Menu)));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> infoElements = [
      Text(
        menu.name,
        style: Theme.of(context).textTheme.headlineSmall,
      )
    ];
    if (menu.note != null) {
      infoElements.add(Text(menu.note as String));
    }

    final AlternatingListTileTheme tileTheme = Theme.of(context).extension<AlternatingListTileTheme>()!;
    return ListTile(
        shape: tileTheme.shape,
        tileColor: (index % 2 == 0)
            ? tileTheme.evenColor
            : tileTheme.oddColor,
        onTap: () {
          navigateToMenu(context);
        },
        leading: const Padding(
            padding: EdgeInsets.all(3),
            child: Icon(
              CustomIcons.food_1,
              size: 50,
            )),
        trailing: IconButton(
          onPressed: () {
            menuListTilePopupMenu.showPopupMenu(context, menu);
          },
          icon: const Icon(Icons.more_vert),
        ),
        title: Text(
          menu.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: menu.note != null ? Text(menu.note as String) : null);
  }
}
