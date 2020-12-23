import 'package:todo_stream/database/database.dart';
import 'package:todo_stream/model/todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

//Add new todo record
  Future createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db.insert('todoTABLE', todo.toDatabaseJson());
    print("create $result");
    // return result;
  }

//delete todo record using it's id
  Future deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete('todoTABLE', where: "id =?", whereArgs: [id]);
    print("delete $result");
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

    // if (query != null) {
    //   if (query.length > 0) {
    //     result = await db.query('todoTABLE',
    //         columns: columns,
    //         where: 'description LIKE?',
    //         whereArgs: ["%$query%"]);
    //   } else {
    //     result = await db.query(
    //       'todoTABLE',
    //       columns: columns,
    //     );
    //   }
    // }
    result = await db.query(
      'todoTABLE',
      columns: columns,
    );
    List<Todo> todos = result.isNotEmpty
        ? result.map((e) => Todo.fromDatabase(e)).toList()
        : [];
    print("get all todos : $todos");
    return todos;
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;

    var result = await db.update(
      'todoTABLE',
      todo.toDatabaseJson(),
      where: "id =?",
      whereArgs: [todo.id],
    );

    return result;
  }

  Future queryDb() async {
    final db = await dbProvider.database;
    var result = await db.query('todoTABLE');
    print(result);
  }
}
