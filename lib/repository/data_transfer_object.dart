import 'package:flutter/cupertino.dart';

abstract class DataTransferObject extends ChangeNotifier{
  Map<String, dynamic> toMap();
  void fromMap(String propertyName, Map<String, dynamic> map);

  dynamic get(String propertyName){
    var map = toMap();
    if(map.containsKey(propertyName)){
      return map[propertyName];
    }
    throw ArgumentError('property not found');
  }

  dynamic set(String propertyName, Object value){
    var map = toMap();
    map[propertyName] = value;
    fromMap(propertyName, map);
    notifyListeners();
  }
}