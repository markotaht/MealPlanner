import 'package:flutter/cupertino.dart';
import 'package:meal_planner/component/component.dart';
import 'package:meal_planner/component/component_service.dart';
import 'package:meal_planner/component/view/component_list_tile.dart';

import '../../components/future_list/future_list.dart';
import '../../initializer.dart';
import '../events/component_cud_event.dart';

class ComponentsList extends StatelessWidget {
  const ComponentsList({super.key});

  @override
  Widget build(BuildContext context) {
    ComponentService service = getIt.get<ComponentService>();
    return FutureList<Component, ComponentCudEvent>(
        dataFunction: service.getAllComponents,
        itemBuilder: (Component data, BuildContext context, int index) =>
            ComponentListTile(
              component: data,
              index: index,
            ));
  }
}