import 'package:flutter/cupertino.dart';
import 'package:meal_planner/component/component.dart';

import '../../repository/repository.dart';

abstract class ComponentRepository extends ChangeNotifier implements Repository<Component>{
  Future<List<Component>> getByMealId(int id);
  Future<List<Component>> getForAutocomplete(String namePart);
}