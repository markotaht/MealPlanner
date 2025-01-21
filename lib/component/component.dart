import 'package:meal_planner/repository/database_object.dart';

import '../repository/data_transfer_object.dart';

class Component extends DataTransferObject implements DatabaseObject{
  @override
  int? id;
  String name;
  String? note;
  DateTime? expirationDate;
  bool runningLow = false;
  List<int>? itemsIds = [];
  
  Component(this.id, this.name, this.note, this.expirationDate, this.runningLow);

  Component.newComponent({required this.name});

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'expirationDate': expirationDate,
      'runningLow': runningLow
    };
  }

  @override
  void fromMap(String propertyName, Map<String, dynamic> map) {
    name = map['name'];
    note = map['note'];
    expirationDate = map['expirationDate'];
    runningLow = map['runningLow'];
  }
}