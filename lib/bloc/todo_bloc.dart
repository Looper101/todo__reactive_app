import 'dart:async';

import 'package:todo_stream/model/date_format.dart';
import 'package:todo_stream/model/date_parser.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/repository/todo_repository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();

  final _todoController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get todos => _todoController.stream;

  //todo counter sink and stream
  final _todoCounterController = StreamController<int>();
  Stream<int> get todoCountStream => _todoCounterController.stream;
  StreamSink<int> get _todoCountSink => _todoCounterController.sink;

  //methods
  // getTodo({String query}) async {
  //   List<Todo> res;
  //   int totalTodos;
  //   _todoController.sink.add(await _todoRepository.getAllTodo(query: query));
  //   res = await _todoRepository.getAllTodo(query: query);
  //   _todoCountSink.add(res.length);
  // }

//TODO: Use this instead of the getTodo methods.........
  getTodoClone() async {
    List<Todo> result;
    result = await _todoRepository.getAllTodo();

    List<Todo> todos = result.isNotEmpty
        ? result
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Todo(
                    addDate: DateParser.fixIncomingDateFromDb(value.addDate),
                    id: value.id,
                    isDone: value.isDone,
                    description: value.description),
              ),
            )
            .values
            .toList()
        : [];
    _todoController.sink.add(todos);
    _todoCountSink.add(todos.length);
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodoClone();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodoClone();
  }

  deleteTodo(int id) async {
    await _todoRepository.deleteTodo(id);
    getTodoClone();
  }

  queryb() async {
    await _todoRepository.queryDb();
  }

  clearDb() async {
    await _todoRepository.clearDb();
    await getTodoClone();
  }

  getDateOnly(Todo todo) async {
    Stream.periodic(Duration(seconds: 1), (value) async {
      var result = await _todoRepository.fetchDate(todo);
      dateSink.add(result);
    });
  }

  Stream<String> get dateStream => _nameController.stream;
  StreamSink<String> get dateSink => _nameController.sink;
  final _nameController = StreamController<String>();

  dispose() {
    _todoController.close();
    _nameController.close();
    _todoCounterController.close();
  }
}

//TODO: add a method(Stream) that run a function every two seconds
// The function will fetch date difference every now and then
