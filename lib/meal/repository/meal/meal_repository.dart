import 'package:flutter/cupertino.dart';
import 'package:meal_planner/meal/model/meal.dart';

import '../../../repository/repository.dart';

abstract class MealRepository extends ChangeNotifier implements Repository<Meal>{
  Future<List<Meal>> getByMenuId(int id);
  Future<List<Meal>> getForAutocomplete(String namePart);
}