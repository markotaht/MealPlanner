import 'package:flutter/material.dart';
import 'package:meal_planner/meal/events/meal_cud_event.dart';
import 'package:meal_planner/meal/meal_service.dart';
import 'package:meal_planner/meal/model/meal.dart';
import 'package:meal_planner/meal/view/meal_list_tile.dart';

import '../../components/future_list/future_list.dart';
import '../../initializer.dart';


class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    MealService service = getIt.get<MealService>();
    return FutureList<Meal, MealCudEvent>(
        dataFunction: service.getAllMeals,
        itemBuilder: (Meal data, BuildContext context, int index) =>
            MealListTile(
              meal: data,
              mealService: service,
              index: index,
            ));
  }
}
/*class MealsList extends StatefulWidget {
  const MealsList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MealsListState();
  }
}

class _MealsListState extends State<MealsList> {
  late StreamSubscription newMealSubscription;
  final MealService mealService = getIt.get<MealService>();
  List<Meal> mealListItems = [];

  @override
  void initState() {
    super.initState();
    newMealSubscription = eventBus.on<MealCudEvent>().listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    newMealSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        initialData: const [],
        future: mealService.getAllMeals(),
        builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return MealListTile(
                    meal: snapshot.data![index],
                    mealService: mealService,
                    index: index,
                  );
                });
          }
          return const Center(
            child: Text("Loading"),
          );
        });
  }
}*/
