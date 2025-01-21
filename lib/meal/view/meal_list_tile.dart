import 'package:flutter/material.dart';
import 'package:meal_planner/meal/meal_service.dart';
import 'package:meal_planner/pages/meal_page/meal_page.dart';

import '../../custom_icons_icons.dart';
import '../model/meal.dart';

class MealListTile extends StatelessWidget{
  const MealListTile({super.key, required this.meal, required this.mealService, required this.index});

  final Meal meal;
  final MealService mealService;
  final int index;

  void navigateToMeal(BuildContext context) async {
    Meal? fullMeal = await mealService.loadFullMealItem(meal.id);
    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MealPage(meal: fullMeal as Meal)));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> infoElements = [
      Text(
        meal.name,
        style: Theme.of(context).textTheme.headlineSmall,
      )
    ];
    if (meal.note != null) {
      infoElements.add(Text(meal.note as String));
    }

    return Container(
        decoration: BoxDecoration(
          border: const Border(bottom: BorderSide(width: 2, color: Color(0xaaaaaaaa))),
          color: (index % 2 == 0) ? const Color(0x00000000) : const Color(0xdddddddd),
        ),
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              navigateToMeal(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3),
                    child: Icon(
                      CustomIcons.food,
                      size: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: infoElements,
                  )
                ],
              ),
            )));
  }

}