import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:meal_planner/initializer.dart';

import 'events/meal_cud_event.dart';
import 'meal_service.dart';
import 'model/meal.dart';

class MealHandler extends ChangeNotifier{
  Meal meal;
  MealService mealService;

  late StreamSubscription mealUpdateSubscription;

  MealHandler({required this.meal}):mealService = getIt.get<MealService>(){
    meal.addListener(saveMeal);
    mealUpdateSubscription = eventBus.on<MealCudEvent>().listen((event) {
      debugPrint("Handler: Meal Updated");
      if (event.meal?.id == meal.id) {
        getData();
      }
    });
  }

  @override
  void dispose(){
    meal.removeListener(saveMeal);
    mealUpdateSubscription.cancel();
    super.dispose();
  }

  void saveMeal() {
    mealService.saveMeal(meal);
  }

  void getData() async {
    meal.removeListener(saveMeal);
    meal = (await mealService.getMealById(meal.id as int))!;
    meal.addListener(saveMeal);
    notifyListeners();
  }
}