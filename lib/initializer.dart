import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_planner/component/repository/component_repository.dart';
import 'package:meal_planner/component/repository/component_repository_impl.dart';
import 'package:meal_planner/meal/meal_service.dart';
import 'package:meal_planner/meal/repository/meal/meal_repository.dart';
import 'package:meal_planner/meal/repository/meal/meal_repository_impl.dart';
import 'package:meal_planner/meal/repository/meal_m_component/meal_m_component_repository.dart';
import 'package:meal_planner/meal/repository/meal_m_component/meal_m_component_repository_impl.dart';
import 'package:meal_planner/menu/repository/menu/menu_repository.dart';
import 'package:meal_planner/menu/repository/menu/menu_repository_impl.dart';
import 'package:meal_planner/menu/menu_service.dart';
import 'package:meal_planner/storage/repository/storage_repository.dart';
import 'package:meal_planner/storage/repository/storage_repository_impl.dart';

import 'component/component.dart';
import 'component/component_service.dart';
import 'meal/model/meal.dart';
import 'menu/menu.dart';
import 'menu/repository/menu_m_meal/menu_m_meal_repository.dart';
import 'menu/repository/menu_m_meal/menu_m_meal_repository_impl.dart';

final getIt = GetIt.instance;
final eventBus = EventBus();

class Initializer {
  static Future<void> initialize() async {
    getIt.registerSingleton<MealMComponentRepository>(
        MealMComponentRepositoryImpl());
    getIt.registerSingleton<ComponentRepository>(ComponentRepositoryImpl(
        mealMComponentRepository: getIt.get<MealMComponentRepository>()));

    getIt.registerSingleton<StorageRepository>(StorageRepositoryImpl());
    getIt.registerSingleton<MenuRepository>(MenuRepositoryImpl());
    getIt.registerSingleton<MenuMMealRepository>(MenuMMealRepositoryImpl());
    getIt.registerSingleton<ComponentService>(ComponentService(
        componentRepository: getIt.get<ComponentRepository>()));

    getIt.registerSingleton<MealRepository>(MealRepositoryImpl(
        menuMMealRepository: getIt.get<MenuMMealRepository>()));
    getIt.registerSingleton<MenuService>(MenuService(
        menuRepository: getIt.get<MenuRepository>(),
        mealRepository: getIt.get<MealRepository>(),
        menuMMealRepository: getIt.get<MenuMMealRepository>(),
        componentRepository: getIt.get<ComponentRepository>()));
    getIt.registerSingleton<MealService>(MealService(
        mealRepository: getIt.get<MealRepository>(),
        componentRepository: getIt.get<ComponentRepository>(),
        mealMComponentRepository: getIt.get<MealMComponentRepository>()));

    await initializeTestData();
  }

  static Future<void> initializeTestData() async {
    MenuRepository menuRepository = getIt.get<MenuRepository>();
    MenuService menuService = getIt.get<MenuService>();
    MealService mealService = getIt.get<MealService>();

    int menuId = await menuRepository.saveItem(Menu.newMenu(name: "Test"));
    await menuRepository.saveItem(Menu.newMenu(name: "Test2"));
    await menuRepository.saveItem(Menu.newMenu(name: "Test3"));
    await menuRepository.saveItem(Menu.newMenu(name: "Test4"));

    Meal item = Meal.newMeal(name: "Piim", categories: ["Dairy"]);
    menuService.addMealToMenu(menuId, item);
    var component = Component.newComponent(name: "Suhkur");
    mealService.addComponentToMeal(item.id as int, component);

    menuService.addMealToMenu(menuId, Meal.newMeal(name: "Jogurt", categories: ["Dairy"]));
    menuService.addMealToMenu(menuId, Meal.newMeal(name: "Hapukoor", categories: ["Dairy"]));
    menuService.addMealToMenu(menuId, Meal.newMeal(name: "Õun", categories: ["Fruit"]));
    menuService.addMealToMenu(menuId, Meal.newMeal(name: "Pirn", categories: ["Fruit"]));
    menuService.addMealToMenu(menuId, Meal.newMeal(name: "Mango", categories: ["Fruit"]));
  }
}
