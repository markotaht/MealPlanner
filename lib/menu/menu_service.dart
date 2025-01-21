import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/meal/model/meal.dart';
import 'package:meal_planner/meal/repository/meal/meal_repository.dart';
import 'package:meal_planner/menu/events/menu_updated_event.dart';
import 'package:meal_planner/menu/repository/menu/menu_repository.dart';
import 'package:meal_planner/menu/repository/menu_m_meal/menu_m_meal_repository.dart';

import '../component/component.dart';
import '../component/repository/component_repository.dart';
import 'events/manu_cud_event.dart';
import 'menu.dart';
import 'menu_m_meal.dart';

class MenuService {
  final MenuRepository menuRepository;
  final MenuMMealRepository menuMMealRepository;
  final MealRepository mealRepository;
  final ComponentRepository componentRepository;

  MenuService(
      {required this.menuRepository,
      required this.mealRepository,
      required this.menuMMealRepository,
      required this.componentRepository});

  Future<List<Menu>> getAllMenus() async {
    List<Menu> menus = await menuRepository.getAll();
    return menus;
  }

  Future<Menu?> getMenuById(int id) async {
    Menu? menu = await menuRepository.getById(id);

    if (menu != null) {
      List<Meal> meals = await mealRepository.getByMenuId(id);
      menu.meals = meals;

      Set<Component> allComponents = {};
      if (meals.isNotEmpty) {
        for (var meal in meals) {
          List<Component> components =
              await componentRepository.getByMealId(meal.id as int);
          allComponents.addAll(components);
        }
        menu.ingredients = allComponents.toList();
      }
    }
    return menu;
  }

  Future<Menu?> loadFullMenuItem(int? id) async {
    if (id == null) return null;
    Menu? menu = await menuRepository.getById(id);

    if (menu != null) {
      List<Meal> meals = await mealRepository.getByMenuId(id);
      menu.meals = meals;

      Set<Component> allComponents = {};
      if (meals.isNotEmpty) {
        for (var meal in meals) {
          List<Component> components =
              await componentRepository.getByMealId(meal.id as int);
          allComponents.addAll(components);
        }
        menu.ingredients = allComponents.toList();
      }
    }
    return menu;
  }

  Future<int> saveMenu(Menu menu) async {
    int id = await menuRepository.saveItem(menu);

    List<Meal> oldItems = await mealRepository.getByMenuId(id);
    List<Meal> newItems = menu.meals;

    for (var item in oldItems) {
      if (!newItems.any((element) => item.id == element.id)) {
        menuMMealRepository.deleteByMenuIdAndItemId(id, item.id as int);
      }
    }

    for (var item in menu.meals) {
      if (!oldItems.any((element) => item.id == element.id)) {
        menuMMealRepository
            .saveItem(MenuMMeal.newMapping(menuId: id, mealId: item.id as int));
      }
    }
    eventBus.fire(MenuCudEvent());
    return id;
  }

  Future<void> deleteMenu(Menu menu) async {
    await menuRepository.deleteItem(menu);
  }

  Future<void> addMealToMenu(int menuId, Meal meal) async {
    int id = await mealRepository.saveItem(meal);
    MenuMMeal? menuMMeal =
        await menuMMealRepository.getByMenuAndMealId(menuId, id);
    if (menuMMeal != null) {
      menuMMeal.visible = true;
    } else {
      menuMMeal = MenuMMeal.newMapping(menuId: menuId, mealId: id);
    }
    menuMMealRepository.saveItem(menuMMeal);
    eventBus.fire(MenuUpdatedEvent((await getMenuById(menuId)) as Menu));
  }

  Future<void> updateItemVisibility(int menuId, int itemId) async {
    menuMMealRepository.toggleItemVisibility(menuId, itemId);

    eventBus.fire(MenuUpdatedEvent((await getMenuById(menuId)) as Menu));
  }

  void addListener(void Function() callback) {
    menuMMealRepository.addListener(callback);
  }

  void removeListener(void Function() callback) {
    menuMMealRepository.removeListener(callback);
  }
}
