
import 'package:flutter/material.dart';
import 'package:meal_planner/menu/menu_handler.dart';
import 'package:meal_planner/pages/menu_page/menu_page_content.dart';

import '../../menu/menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.menu});

  final Menu menu;

  @override
  State<StatefulWidget> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
  late MenuHandler menuHandler;

  @override
  void initState() {
    super.initState();
    menuHandler = MenuHandler(menu: widget.menu);
  }

  @override
  void dispose() {
    menuHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: menuHandler,
        builder: (BuildContext context, Widget? child) {
          return MenuPageContent(menu: menuHandler.menu);
        });
  }
}
