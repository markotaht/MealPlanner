import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/component/view/component_list_item.dart';

import '../../component/component.dart';

class IngredientsTab extends StatelessWidget{
  const IngredientsTab({super.key, this.components});

  final List<Component>? components;

  @override
  Widget build(BuildContext context) {
    return
      components != null && components!.isNotEmpty ?
      ListView.builder(
        itemCount: components?.length,
        itemBuilder: (BuildContext context, int index) {
          return ComponentListItem(component: components![index]);
        }) : const Center(child: Text("No Ingredients"));
  }

}