import 'package:flutter/cupertino.dart';
import 'package:meal_planner/repository/database_object.dart';
import 'package:meal_planner/repository/repository.dart';

abstract class InMemoryRepository<T extends DatabaseObject>
    with ChangeNotifier implements Repository<T> {
  int currentIndex = 0;
  Map<int, T> items = {};

  @override
  Future<int> saveItem(T itemMapping) async {
    if(itemMapping.id != null){
      items[itemMapping.id as int] = itemMapping;
    } else {
      itemMapping.id = currentIndex;
      items[currentIndex] = itemMapping;
      currentIndex++;
    }
    notifyListeners();
    return itemMapping.id as int;
  }

  @override
  Future<List<T>> getAll() async {
    return items.values.toList();
  }

  @override
  Future<T?> getById(int id) async {
    return items[id];
  }

  @override
  Future<void> deleteItem(T itemMapping) async {
    items.remove(itemMapping.id as int);
    notifyListeners();
  }
}
