import 'package:flutter/material.dart';
import 'package:meal_planner/component/view/components_list.dart';
import 'package:meal_planner/components/BottomApplicationBar/bottom_application_bar.dart';
import 'package:meal_planner/components/BottomApplicationBar/bottom_application_bar_item.dart';
import 'package:meal_planner/components/BottomApplicationBar/bottom_application_bar_padding_item.dart';
import 'package:meal_planner/components/floating_action_buttons/add_meal_fab_button.dart';
import 'package:meal_planner/components/floating_action_buttons/add_component_fab.dart';
import 'package:meal_planner/meal/view/meals_list.dart';

import '../components/floating_action_buttons/add_menu_fab.dart';
import '../custom_icons_icons.dart';
import '../menu/view/menus_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    MenusList(),
    MealsList(),
    ComponentsList(),
  ];

  static const List<Widget> _fabOptions = [
    AddMenuFab(),
    AddMealFabButton(),
    AddComponentFab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_selectedIndex.toString());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title)),
        body: _widgetOptions[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _fabOptions[_selectedIndex],
        bottomNavigationBar: BottomApplicationBar(
          items: const [
            BottomApplicationBarItem(
                icon: Icon(CustomIcons.food_menu), label: "Menus"),
            BottomApplicationBarItem(
                icon: Icon(CustomIcons.food), label: "Meals"),
            BottomApplicationBarItem(
                icon: Icon(CustomIcons.ingredients), label: "Ingredients"),
            BottomApplicationBarPaddingItem(width: 60)
          ],
          onTap: _onItemTapped,
        ));
  }
}
