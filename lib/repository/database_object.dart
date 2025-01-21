abstract class DatabaseObject{
  int? id;

  DatabaseObject(this.id);
  DatabaseObject.newObject();

  Map<String, dynamic> toMap();
}