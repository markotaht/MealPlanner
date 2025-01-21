import 'package:meal_planner/repository/database_object.dart';

class MenuMMeal extends DatabaseObject {
  final int menuId;
  final int mealId;
  bool visible = true;

  MenuMMeal(super.id, this.menuId, this.mealId);

  MenuMMeal.newMapping({required this.menuId, required this.mealId})
      : super.newObject();

  MenuMMeal.fromMap(Map<String, dynamic> menuMItem)
      : menuId = menuMItem["menuId"],
        mealId = menuMItem["mealId"],
        visible = menuMItem["visible"],
        super(menuMItem["id"]);

  @override
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "menuId": menuId,
      "mealId": mealId,
      "visible": visible
    };
    map["id"] = id;
    return map;
  }
}
