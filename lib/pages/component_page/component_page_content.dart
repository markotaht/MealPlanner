import 'package:flutter/material.dart';
import 'package:meal_planner/components/propetries/bool_property.dart';

import '../../custom_icons_icons.dart';
import '../../components/propetries/date_property.dart';
import '../../components/propetries/text_property.dart';
import '../../component/component.dart';

class ComponentPageContent extends StatelessWidget {
  const ComponentPageContent({super.key, required this.component});

  final Component component;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Ingredient Details'),
        ),
        body: Column(
          children: [
            TextProperty(
              leading: const Icon(CustomIcons.edit),
              title: 'Name',
              object: component,
              field: 'name',
            ),
            TextProperty(
                leading: const Icon(CustomIcons.edit),
                title: 'Note',
                object: component,
                field: 'note'),
            DateProperty(
                leading: const Icon(CustomIcons.edit),
                title: "Expiration Date",
                object: component,
                field: 'expirationDate'),
            BoolProperty(
                leading: const Icon(CustomIcons.edit),
                title: "Running Low",
                object: component,
                field: 'runningLow')
          ],
        ));
  }
}
