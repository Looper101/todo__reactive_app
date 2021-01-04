import 'package:sqflite/sql.dart';
import 'package:todo_stream/database/database.dart';
import 'package:todo_stream/model/todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

//Add new todo record
  Future createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db.insert('todoTABLE', todo.toDatabaseJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("create $result");
    return result;
  }

//delete todo record using it's id
  Future deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete('todoTABLE', where: "id =?", whereArgs: [id]);
    print("delete $result");
    return result;
  }

  // //Delete all todo
  // Future<int> deleteAllTodo() async {
  //   final db = await dbProvider.database;
  //   var result = await db.delete('todoTABLE');
  //   return result;
  // }

  //Get all todo items
  //Searches if query was passed
  Future<List<Todo>> getTodos({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;

    if (query != null) {
      result = await db.query('todoTABLE',
          columns: columns,
          orderBy: 'id DESC',
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]);
    } else {
      result =
          await db.query('todoTABLE', columns: columns, orderBy: 'id DESC');
    }

    result = await db.query(
      'todoTABLE',
      columns: columns,
      orderBy: 'id DESC',
    );
    List<Todo> todos = result.isNotEmpty
        ? result.map((e) => Todo.fromDatabase(e)).toList()
        : [];

    //manipulate evry todos in the todosList above..
    // return manipulate(todos);

    return todos;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    try {
      var result = await db.update(
        'todoTABLE',
        todo.toDatabaseJson(),
        where: "id =?",
        whereArgs: [todo.id],

        // conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print("update: $result");
      return result;
    } catch (e, stacktrace) {
      print('errorMessage: $e ---stacktrace : $stacktrace');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> queryDb() async {
    final db = await dbProvider.database;
    var result = await db.query('todoTABLE');
    print("QUERY : $result");
    return result;
  }

  Future clearDb() async {
    final db = await dbProvider.database;
    await db.delete(
      'todoTABLE',
      where: '1',
    );
  }

  Future<String> getDateOnly(Todo todo) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;
    result = await db.query('todoTABLE', where: "id=?", whereArgs: [todo.id]);

    List<Todo> todos = result.isNotEmpty
        ? result.map((e) => Todo.fromDatabase(e)).toList()
        : [];

    return todos[0].addDate;
  }

  Future<int> clearDbMain() async {
    final db = await dbProvider.database;
    await db.delete('todoTABLE');
  }
}
