import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/menu/menu_service.dart';

import '../meal/events/meal_cud_event.dart';
import 'events/menu_updated_event.dart';
import 'menu.dart';

class MenuHandler extends ChangeNotifier{
  Menu menu;
  MenuService menuService;

  late StreamSubscription mealUpdateSubscription;
  late StreamSubscription menuUpdateSubscription;

  MenuHandler({required this.menu}):menuService = getIt.get<MenuService>(){


    menuUpdateSubscription = eventBus.on<MenuUpdatedEvent>().listen((event) {
      getData();
    });
    mealUpdateSubscription = eventBus.on<MealCudEvent>().listen((event) {
      getData();
    });
  }

  @override
  void dispose(){
    mealUpdateSubscription.cancel();
    menuUpdateSubscription.cancel();
    super.dispose();
  }

  void getData() async {
    menu = (await menuService.loadFullMenuItem(menu.id as int))!;
    notifyListeners();
  }
}