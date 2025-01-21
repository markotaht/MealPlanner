import 'package:flutter/material.dart';
import 'package:meal_planner/meal/meal_service.dart';
import 'package:meal_planner/meal/model/meal.dart';

import '../../custom_icons_icons.dart';
import '../../initializer.dart';
import '../../menu/menu.dart';
import '../../menu/menu_service.dart';

class AddMealFabButton extends StatefulWidget {
  const AddMealFabButton({super.key, this.menu});

  final Menu? menu;

  @override
  State<StatefulWidget> createState() {
    return _AddMealFabButtonState();
  }
}

class _AddMealFabButtonState extends State<AddMealFabButton> {
  bool visible = true;
  MealService mealService = getIt.get<MealService>();
  MenuService menuService = getIt.get<MenuService>();
  String? _searchingWithQuery;
  late Iterable<Meal> _lastOptions = [];

  void _onSubmit(Meal meal, BuildContext context) {
      if (widget.menu != null) {
        menuService.addMealToMenu(widget.menu?.id as int, meal);
      } else {
        mealService.saveMeal(meal);
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
        child: Autocomplete<Meal>(
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
                _onSubmit(Meal.newMeal(name: val, categories: ["Other"]), context);
              },
              autofocus: true,
            );
          },
          optionsViewOpenDirection: OptionsViewOpenDirection.up,
          displayStringForOption: (Meal component) => component.name,
          optionsBuilder: (TextEditingValue editingValue) async {
            _searchingWithQuery = editingValue.text;
            if (editingValue.text == '') {
              return const Iterable.empty();
            }
            final Iterable<Meal> options =
                await mealService.getForAutocomplete(_searchingWithQuery!);
            if (_searchingWithQuery != editingValue.text) {
              return _lastOptions;
            }
            debugPrint(options.toString());
            _lastOptions = options;
            return options;
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<Meal> onSelected, Iterable<Meal> options) {
            return Align(
              alignment: Alignment.bottomLeft,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  height: 200.0, // Change as per your requirement
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Meal option = options.elementAt(index);
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
          onSelected: (Meal meal) {
            _onSubmit(meal, context);
          },
        )));
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
