import 'package:meal_planner/repository/database_object.dart';

class MealMComponent extends DatabaseObject {
  final int mealId;
  final int componentId;
  MealMComponent(super.id, this.mealId, this.componentId);

  MealMComponent.newMapping({required this.mealId, required this.componentId})
      : super.newObject();

  get(String propertyName) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}