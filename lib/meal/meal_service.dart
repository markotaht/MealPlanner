import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/meal/events/meal_cud_event.dart';
import 'package:meal_planner/meal/model/meal_m_component.dart';
import 'package:meal_planner/meal/repository/meal/meal_repository.dart';
import 'package:meal_planner/meal/repository/meal_m_component/meal_m_component_repository.dart';

import '../component/component.dart';
import '../component/repository/component_repository.dart';
import 'model/meal.dart';

class MealService {
  final MealMComponentRepository mealMComponentRepository;
  final MealRepository mealRepository;
  final ComponentRepository componentRepository;

  MealService(
      {required this.mealMComponentRepository,
      required this.mealRepository,
      required this.componentRepository});

  Future<Meal?> getMealById(int id) async {
    Meal? meal = await mealRepository.getById(id);

    if (meal != null) {
      List<Component> components = await componentRepository.getByMealId(id);
      meal.components = components;
    }
    return meal;
  }

  Future<Meal?> loadFullMealItem(int? id) async {
    if (id == null) return null;

    Meal? meal = await mealRepository.getById(id);

    if (meal != null) {
      List<Component> components = await componentRepository.getByMealId(id);
      meal.components = components;
    }
    return meal;
  }

  Future<void> saveMeal(Meal meal) async {
    await mealRepository.saveItem(meal);
    eventBus.fire(MealCudEvent(meal));
  }

  Future<List<Meal>> getAllMeals() async {
    return mealRepository.getAll();
  }

  Future<void> addComponentToMeal(int mealId, Component component) async {
    int id = await componentRepository.saveItem(component);
    mealMComponentRepository
        .saveItem(MealMComponent.newMapping(mealId: mealId, componentId: id));

    eventBus.fire(MealCudEvent(await getMealById(mealId)));
  }

  Future<List<Meal>> getForAutocomplete(String namePart) async {
    return mealRepository.getForAutocomplete(namePart);
  }
}
