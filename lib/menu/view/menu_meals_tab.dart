import 'package:flutter/cupertino.dart';
import 'package:meal_planner/initializer.dart';

import '../../categorized_list_view.dart';
import '../../meal/model/meal.dart';
import '../menu.dart';
import '../menu_service.dart';

class MenuMealsTab extends StatelessWidget {
  const MenuMealsTab({super.key, required this.menu, this.showHidden = false});

  final Menu menu;
  final bool showHidden;

  MenuService get menuService => getIt.get<MenuService>();

  void _onItemTap(int id) {
    menuService.updateItemVisibility(menu.id as int, id);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<CategoryItem>> categorizedItems = {};
    List<Meal> items = menu.meals;
    for (var item in items) {
      for (var category in item.categories) {
        var newItem = CategoryItem(
            id: item.id as int, title: item.name, category: category, visible: item.visible as bool, object: item);
        categorizedItems.update(
            category, (value) => {...value, newItem}.toList(),
            ifAbsent: () => [newItem]);
      }
    }

    List<Category> parsedItems = [];
    for (var entry in categorizedItems.entries) {
      parsedItems.add(Category(title: entry.key, items: entry.value));
    }

    return CategorizedListView(
      categories: parsedItems,
      onItemTap: _onItemTap,
      showHidden: showHidden,
    );
  }
}
