import 'package:meal_planner/meal/model/meal.dart';
import 'package:meal_planner/repository/database_object.dart';

import '../component/component.dart';

class Menu extends DatabaseObject {
  final String name;
  final String? note;

  late List<Meal> meals = [];
  late List<Component> ingredients = [];

  Menu(super.id,this.name, this.note);
  Menu.newMenu({required this.name, this.note}): super.newObject();

  Menu.fromMap(Map<String, dynamic> menu)
      : name = menu["name"],
        note = menu["note"],
        super(menu["id"]);

  Menu update(Map<String, dynamic> newValues){
    return Menu.fromMap({...toMap(), ...newValues});
  }

  @override
  Map<String, Object?> toMap() {
    var map = <String, Object?>{"name": name};
    map["id"] = id;

    if(note != null){
      map["note"] = note;
    }
    return map;
  }

  get(String propertyName) {
    // TODO: implement get
    throw UnimplementedError();
  }
}