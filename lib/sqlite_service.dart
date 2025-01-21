import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static Database? _database;

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Component("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name TEXT NOT NULL,"
        "note TEXT,"
        "category TEXT,"
        "favourite INTEGER"
        ")");
  }

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: _onCreate,
      version : 1
    );
  }

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initializeDb();
    return _database!;
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    final db = await database;
    final id = await db.insert(table, values,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Map<String, Object?>>> getById(String table, int id) async {
    final db = await database;
    return await db.query(table, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> getAll(String table) async {
    final db = await database;
    return await db.query(table);
  }
}