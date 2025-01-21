import 'package:flutter/cupertino.dart';
import 'package:meal_planner/repository/repository.dart';

import '../../menu_m_meal.dart';

abstract class MenuMMealRepository extends ChangeNotifier implements Repository<MenuMMeal>{
  Future<List<MenuMMeal>> getByMenuId(int id);
  Future<MenuMMeal?> getByMenuAndMealId(int menuId, int mealId);
  Future<void> deleteByMenuIdAndItemId(int menuId, int itemId);
  Future<void> toggleItemVisibility(int menuId, int itemId);
}