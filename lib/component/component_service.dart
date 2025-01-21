import 'package:meal_planner/component/events/component_cud_event.dart';
import 'package:meal_planner/component/repository/component_repository.dart';

import '../initializer.dart';
import 'component.dart';

class ComponentService {
  final ComponentRepository componentRepository;

  ComponentService({required this.componentRepository});

  Future<void> saveComponent(Component component) async {
    await componentRepository.saveItem(component);
    eventBus.fire(ComponentCudEvent(component));
  }

  Future<List<Component>> getAllComponents() async {
    return componentRepository.getAll();
  }

  Future<List<Component>> getForAutocomplete(String namePart) async {
    return componentRepository.getForAutocomplete(namePart);
  }

  Future<Component?> getComponentById(int id) async {
    return componentRepository.getById(id);
  }
}
