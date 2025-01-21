import 'package:flutter/material.dart';
import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/meal/meal_service.dart';
import '../../custom_icons_icons.dart';
import '../model/meal.dart';

class AddRecipeFloatingButton extends StatefulWidget {
  const AddRecipeFloatingButton({super.key, required this.meal});

  final Meal meal;

  @override
  State<StatefulWidget> createState() {
    return _AddRecipeFloatingButtonState();
  }
}

class _AddRecipeFloatingButtonState extends State<AddRecipeFloatingButton> {
  bool visible = true;
  late TextEditingController textEditingController;
  MealService mealService = getIt.get<MealService>();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  void _closeSheet(BuildContext context) {
    Navigator.pop(context);
    setState(() {
      visible = true;
    });
  }

  void _onSubmit(String text, BuildContext context) {
    widget.meal.recipe = text;
    mealService.saveMeal(widget.meal);
    textEditingController.clear();
    _closeSheet(context);
  }

  void _addNewItem(BuildContext context) async {
    String? value = widget.meal.recipe;
    if (value != null) {
      textEditingController.text = value;
    }

    setState(() {
      visible = false;
    });
    Scaffold.of(context).showBottomSheet((context) => TapRegion(
          onTapOutside: (e) {
            _closeSheet(context);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  autofocus: true,
                  onSubmitted: (value) {
                    _onSubmit(value, context);
                  },
                )),
                IconButton(
                    onPressed: () {
                      _onSubmit(textEditingController.text, context);
                    },
                    icon: const Icon(CustomIcons.check))
              ])),
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
            child: const Icon(CustomIcons.edit)));
  }
}
