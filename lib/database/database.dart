import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final todoTable = 'todoTABLE';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, "reactiveTodo.db");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE $todoTable("
            "id INTEGER PRIMARY KEY,"
            "description TEXT,"
            "is_done INTEGER"
            ")");
      },
    );

    return database;
  }
}
