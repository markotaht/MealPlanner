import 'package:flutter/cupertino.dart';
import 'package:meal_planner/components/floating_action_buttons/add_meal_fab_button.dart';
import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/meal/meal_service.dart';

class AddMealFab extends StatelessWidget {
  const AddMealFab({super.key});

  MealService get mealService => getIt.get<MealService>();

  @override
  Widget build(BuildContext context) {
    return const AddMealFabButton();
  }
}
