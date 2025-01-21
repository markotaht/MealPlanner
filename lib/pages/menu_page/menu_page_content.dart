import 'package:flutter/material.dart';
import 'package:meal_planner/components/tabbed_fab/tab_floating_action_button.dart';
import 'package:meal_planner/meal/view/ingredients_tab.dart';

import '../../components/floating_action_buttons/add_meal_fab_button.dart';
import '../../menu/menu.dart';
import '../../menu/view/menu_meals_tab.dart';
import '../../menu/view/menu_page_footer.dart';

class MenuPageContent extends StatefulWidget {
  const MenuPageContent({super.key, required this.menu});

  final Menu menu;

  @override
  State<StatefulWidget> createState() {
    return _MenuPageContentState();
  }
}

class _MenuPageContentState extends State<MenuPageContent>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool showHidden = false;
  bool favourite = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _toggleFavourite() {
    setState(() {
      favourite = !favourite;
    });
  }

  void _toggleShowHidden() {
    setState(() {
      showHidden = !showHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.menu.name),
        bottom: TabBar(
          controller: tabController,
          tabs: const [Tab(text: "Meals"), Tab(text: "Ingredients")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          MenuMealsTab(menu: widget.menu, showHidden: showHidden),
          IngredientsTab(components: widget.menu.ingredients)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          TabFloatingActionButton(tabController: tabController, children: [
        AddMealFabButton(
          menu: widget.menu,
        ),
        null
      ]),
      bottomNavigationBar: MenuPageFooter(
          favourite: favourite,
          showHidden: showHidden,
          toggleFavourite: _toggleFavourite,
          toggleShowHidden: _toggleShowHidden),
    );
  }
}
