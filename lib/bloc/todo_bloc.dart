import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/repository/todo_repository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();

  //controllers
  final _todoController = BehaviorSubject<List<Todo>>();
  final _todoCounterController = BehaviorSubject<int>();

//get
  Stream<int> get todoCountStream => _todoCounterController.stream;
  Stream<List<Todo>> get todos => _todoController.stream;

  //set
  StreamSink<int> get _todoCountSink => _todoCounterController.sink;

  //methods
  Future<void> getTodo({String query}) async {
    List<Todo> res;
    _todoController.sink.add(await getTodoClone());
    res = await getTodoClone();
    _todoCountSink.add(res.length);
  }

  Future<List<Todo>> getTodoClone() async {
    List<Todo> result;
    result = await _todoRepository.getAllTodo();

    List<Todo> todos = result.isNotEmpty
        ? result
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Todo(
                  addDate: value.addDate,
                  id: value.id,
                  isDone: value.isDone,
                  description: value.description,
                ),
              ),
            )
            .values
            .toList()
        : [];

    return todos;
  }

//Crud operations

  Future<Stream<Duration>> dateEmmitter(DateTime dateTime) async {
    return Stream<Duration>.periodic(
      Duration(seconds: 1),
      (x) {
        Duration remDate = DateTime.now().difference(dateTime);
        return remDate;
      },
    );
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
    await getTodo();
  }

//completed task.........❤❤

  dispose() {
    _todoController.close();
    // _nameController.close();
    _todoCounterController.close();
  }
}
