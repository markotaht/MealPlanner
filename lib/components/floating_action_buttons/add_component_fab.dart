import 'package:flutter/material.dart';
import 'package:meal_planner/component/component.dart';
import 'package:meal_planner/component/component_service.dart';
import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/meal/meal_service.dart';

import '../../custom_icons_icons.dart';
import '../../meal/model/meal.dart';

class AddComponentFab extends StatefulWidget {
  const AddComponentFab({super.key, this.meal});

  final Meal? meal;

  @override
  State<StatefulWidget> createState() {
    return _AddComponentFabState();
  }
}

class _AddComponentFabState
    extends State<AddComponentFab> {
  bool visible = true;
  ComponentService componentService = getIt.get<ComponentService>();
  MealService mealService = getIt.get<MealService>();
  String? _searchingWithQuery;
  late Iterable<Component> _lastOptions = [];

  void _onSubmit(Component component, BuildContext context) {
    if (widget.meal != null) {
      mealService.addComponentToMeal(widget.meal?.id as int, component);
    } else {
      componentService.saveComponent(component);
    }
    Navigator.pop(context);
    setState(() {
      visible = true;
    });
  }

  void _addNewItem(BuildContext context) async {
    setState(() {
      visible = false;
    });
    Scaffold.of(context).showBottomSheet((context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Autocomplete<Component>(
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                onSubmitted: (String val) {
                  onFieldSubmitted();
                  _onSubmit(Component.newComponent(name: val), context);
                },
                autofocus: true,
              );
            },
            optionsViewOpenDirection: OptionsViewOpenDirection.up,
            displayStringForOption: (Component component) => component.name,
            optionsBuilder: (TextEditingValue editingValue) async {
              _searchingWithQuery = editingValue.text;
              if (editingValue.text == '') {
                return const Iterable.empty();
              }
              final Iterable<Component> options = await componentService
                  .getForAutocomplete(_searchingWithQuery!);
              if (_searchingWithQuery != editingValue.text) {
                return _lastOptions;
              }
              debugPrint(options.toString());
              _lastOptions = options;
              return options;
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<Component> onSelected,
                Iterable<Component> options) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: Material(
                  elevation: 4.0,
                  child: SizedBox(
                    height: 200.0, // Change as per your requirement
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Component option = options.elementAt(index);
                        return ListTile(
                          title: Text(option.name),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (Component component) {
              _onSubmit(component, context);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visible,
        child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              _addNewItem(context);
            },
            child: const Icon(CustomIcons.plus)));
  }
}
