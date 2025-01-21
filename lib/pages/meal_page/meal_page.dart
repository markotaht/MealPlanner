import 'package:flutter/material.dart';
import 'package:meal_planner/meal/meal_handler.dart';
import 'package:meal_planner/pages/meal_page/meal_page_content.dart';

import '../../meal/model/meal.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key, required this.meal});

  final Meal meal;

  @override
  State<StatefulWidget> createState() {
    return _MealPageState();
  }
}

class _MealPageState extends State<MealPage> {
  late MealHandler mealHandler;

  @override
  void initState() {
    super.initState();
    mealHandler = MealHandler(meal: widget.meal);
  }

  @override
  void dispose(){
    mealHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: mealHandler,
        builder: (BuildContext context, Widget? child) {
          debugPrint("Render content");
          return MealPageContent(meal: mealHandler.meal);
        });
  }
}
