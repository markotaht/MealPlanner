import 'database_object.dart';

mixin Repository<T extends DatabaseObject>{

  Future<int> saveItem(T item);

  Future<T?> getById(int id);

  Future<List<T>> getAll();

  Future<void> deleteItem(T item);
}