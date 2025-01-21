import 'package:meal_planner/meal/model/meal_m_component.dart';
import 'package:meal_planner/meal/repository/meal_m_component/meal_m_component_repository.dart';

import '../../../repository/in_memory_repository.dart';

class MealMComponentRepositoryImpl extends InMemoryRepository<MealMComponent> implements MealMComponentRepository{
  @override
  Future<List<MealMComponent>> getByMealId(int id) async {
    List<MealMComponent> items = [];
    for (var item in super.items.values) {
      if (item.mealId == id) {
        items.add(item);
      }
    }

    return items;
  }
}