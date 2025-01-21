import 'package:meal_planner/component/repository/component_repository.dart';
import 'package:meal_planner/meal/model/meal_m_component.dart';
import 'package:meal_planner/meal/repository/meal_m_component/meal_m_component_repository.dart';

import '../../repository/in_memory_repository.dart';
import '../component.dart';

class ComponentRepositoryImpl extends InMemoryRepository<Component>
    implements ComponentRepository {
  final MealMComponentRepository mealMComponentRepository;

  ComponentRepositoryImpl({required this.mealMComponentRepository});

  @override
  Future<List<Component>> getByMealId(int id) async {
    List<MealMComponent> mealMComponent =
        await mealMComponentRepository.getByMealId(id);
    List<Component> components = [];
    for (var mapItem in mealMComponent) {
      if (super.items.containsKey(mapItem.componentId)) {
        Component? component = super.items[mapItem.componentId];
        // component?.visible = mapItem.visible;
        components.add(component!);
      }
    }

    return components;
  }

  @override
  Future<List<Component>> getForAutocomplete(String namePart) async {
    return super
        .items
        .values
        .where((element) => element.name.contains(namePart))
        .toList();
  }
}
