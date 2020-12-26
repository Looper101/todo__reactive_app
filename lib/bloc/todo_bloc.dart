import 'dart:async';

import 'package:todo_stream/model/date_format.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/repository/todo_repository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();

  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todos => _todoController.stream;

  getTodo({String query}) async {
    _todoController.sink.add(await _todoRepository.getAllTodo(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodo();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodo();
  }

  deleteTodo(int id) async {
    await _todoRepository.deleteTodo(id);
    getTodo();
  }

  queryb() async {
    await _todoRepository.queryDb();
  }

  clearDb() async {
    await _todoRepository.clearDb();
    await queryb();
  }

  dispose() {
    _todoController.close();
  }
}

//TODO: add a method(Stream) that run a function every two seconds
// The function will fetch date difference every now and then
