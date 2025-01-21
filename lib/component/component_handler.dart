import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:meal_planner/component/component_service.dart';
import 'package:meal_planner/component/events/component_cud_event.dart';
import 'package:meal_planner/initializer.dart';

import 'component.dart';


class ComponentHandler extends ChangeNotifier{
  Component component;
  ComponentService componentService;

  late StreamSubscription mealUpdateSubscription;

  ComponentHandler({required this.component}):componentService = getIt.get<ComponentService>(){
    component.addListener(saveMeal);
    mealUpdateSubscription = eventBus.on<ComponentCudEvent>().listen((event) {
      debugPrint("Handler: Meal Updated");
      if (event.component.id == component.id) {
        getData();
      }
    });
  }

  @override
  void dispose(){
    component.removeListener(saveMeal);
    mealUpdateSubscription.cancel();
    super.dispose();
  }

  void saveMeal() {
    componentService.saveComponent(component);
  }

  void getData() async {
    component.removeListener(saveMeal);
    component = (await componentService.getComponentById(component.id as int))!;
    component.addListener(saveMeal);
    notifyListeners();
  }
}