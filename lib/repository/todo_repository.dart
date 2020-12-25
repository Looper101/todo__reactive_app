import 'package:todo_stream/dao/todo_dao.dart';
import 'package:todo_stream/model/todo.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future<List<Todo>> getAllTodo({String query}) async =>
      await todoDao.getTodos(query: query);

  Future<int> insertTodo(Todo todo) async {
    await todoDao.createTodo(todo);
  }

  Future<int> updateTodo(Todo todo) async => await todoDao.updateTodo(todo);
  Future<int> deleteTodo(int id) async => await todoDao.deleteTodo(id);
  // Future<int> deleteAllTodo() async => await todoDao.deleteAllTodo();
  Future queryDb() async => await todoDao.queryDb();
}
