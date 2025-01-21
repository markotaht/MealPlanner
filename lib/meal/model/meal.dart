import 'package:meal_planner/repository/data_transfer_object.dart';
import 'package:meal_planner/repository/database_object.dart';

import '../../component/component.dart';

class Meal extends DataTransferObject implements DatabaseObject {
  @override
  int? id;
  String name;
  String? note;
  List<String> categories;
  DateTime? expirationDate;
  String? recipe;

  bool? favourite;
  bool? visible = true;

  List<Component>? components;

  Meal.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        note = map['note'],
        categories = map['categories'],
        expirationDate = map['expirationDate'],
        recipe = map['recipe'],
        components = map['components'],
        id = map["id"];

  Meal.newMeal({required this.name, required this.categories});

  @override
  Map<String, dynamic> toMap() {
      return {
        'name': name,
        'note': note,
        'categories': categories,
        'expirationDate': expirationDate,
        'recipe': recipe,
        'components': components
      };
  }

  @override
  void fromMap(String propertyName, Map<String, dynamic> map) {
    name = map['name'];
    note = map['note'];
    categories = map['categories'];
    expirationDate = map['expirationDate'];
    recipe = map['recipe'];
    components = map['components'];
  }
}
