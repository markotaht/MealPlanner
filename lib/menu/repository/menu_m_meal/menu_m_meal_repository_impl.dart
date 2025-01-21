import 'package:meal_planner/repository/in_memory_repository.dart';

import '../../menu_m_meal.dart';
import 'menu_m_meal_repository.dart';

class MenuMMealRepositoryImpl extends InMemoryRepository<MenuMMeal>
    implements MenuMMealRepository {
  @override
  Future<List<MenuMMeal>> getByMenuId(int id) async {
    List<MenuMMeal> items = [];
    for (var item in super.items.values) {
      if (item.menuId == id) {
        items.add(item);
      }
    }

    return items;
  }

  @override
  Future<MenuMMeal?> getByMenuAndMealId(int menuId, int mealId) async{
    for (var item in super.items.values) {
      if (item.menuId == menuId && item.mealId == mealId) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<void> deleteByMenuIdAndItemId(int menuId, int itemId) async {
    for (var item in super.items.values) {
      if (item.menuId == menuId && item.mealId == itemId) {
        items.remove(item.id);
      }
    }
  }

  @override
  Future<void> toggleItemVisibility(int menuId, int itemId) async {
    MenuMMeal item = items.values.firstWhere(
        (element) => element.menuId == menuId && element.mealId == itemId);
    item.visible = !item.visible;
    saveItem(item);
  }
}
