
import 'package:flutter/material.dart';
import 'package:meal_planner/components/tabbed_fab/tab_floating_action_button.dart';
import 'package:meal_planner/components/floating_action_buttons/add_component_fab.dart';
import 'package:meal_planner/meal/model/meal.dart';
import 'package:meal_planner/meal/view/add_recipe_floating_button.dart';
import 'package:meal_planner/meal/view/ingredients_tab.dart';
import 'package:meal_planner/meal/view/general_tab.dart';
import 'package:meal_planner/meal/view/recipe_tab.dart';


class MealPageContent extends StatefulWidget {
  const MealPageContent({super.key, required this.meal});

  final Meal meal;

  @override
  State<StatefulWidget> createState() {
    return _MealPageContentState();
  }
}

class _MealPageContentState extends State<MealPageContent>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Details"),
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(text: "General"),
          Tab(text: "Ingredients"),
          Tab(text: "Recipe")
        ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          GeneralTab(meal: widget.meal),
          IngredientsTab(components: widget.meal.components),
          RecipeTab(recipe: widget.meal.recipe),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: TabFloatingActionButton(
        tabController: tabController,
        children: [
          null,
          AddComponentFab(meal: widget.meal),
          AddRecipeFloatingButton(meal: widget.meal)
        ],
      ),
    );
  }
}
