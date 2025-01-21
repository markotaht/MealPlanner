import 'package:flutter/cupertino.dart';
import 'package:meal_planner/meal/model/meal_m_component.dart';

import '../../../repository/repository.dart';

abstract class MealMComponentRepository extends ChangeNotifier implements Repository<MealMComponent>{
  Future<List<MealMComponent>> getByMealId(int id);
}