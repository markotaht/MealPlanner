import 'package:meal_planner/meal/model/meal.dart';
import 'package:meal_planner/meal/repository/meal/meal_repository.dart';

import '../../../menu/menu_m_meal.dart';
import '../../../menu/repository/menu_m_meal/menu_m_meal_repository.dart';
import '../../../repository/in_memory_repository.dart';

class MealRepositoryImpl extends InMemoryRepository<Meal> implements MealRepository{
  final MenuMMealRepository menuMMealRepository;

  MealRepositoryImpl({required this.menuMMealRepository});

  @override
  Future<List<Meal>> getByMenuId(int id) async {
    List<MenuMMeal> menuMMeal = await menuMMealRepository.getByMenuId(id);
    List<Meal> meals = [];
    for(var mapItem in menuMMeal){
      if(super.items.containsKey(mapItem.mealId)){
        Meal? meal = super.items[mapItem.mealId];
        meal?.visible = mapItem.visible;
        meals.add(meal!);
      }
    }

    return meals;
  }

  @override
  Future<List<Meal>> getForAutocomplete(String namePart) async {
    return super
        .items
        .values
        .where((element) => element.name.contains(namePart))
        .toList();
  }
}