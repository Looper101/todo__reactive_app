import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todo_stream/model/date_parser.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/repository/todo_repository.dart';

class TaskCounterBloc {
//Completed bloc

  final _todoRepository = TodoRepository();

  getCountData() async {
    await getCompletedTask();
    await getAllTask();
    await getThisWeekTask();
    await getTodayTask();
  }

  Future getCompletedTask() async {
    List<Todo> result = await _todoRepository.getCompletedTasks();
    var taskLength = result.length;
    completedTaskCounterSink.add(taskLength);
  }

  Stream<int> get completedTaskCounterStream =>
      _completedTaskCounterController.stream;
  StreamSink<int> get completedTaskCounterSink =>
      _completedTaskCounterController.sink;
  final _completedTaskCounterController = BehaviorSubject<int>();

//🔻All Task🔻
//set //& get
  Sink<int> get allTaskSink => _allTaskController.sink;
  Stream<int> get allTaskStream => _allTaskController.stream;
  final _allTaskController = BehaviorSubject<int>.seeded(0);

  Future getAllTask() async {
    List<Todo> result = await _todoRepository.getAllTodo();
    var allTaskLength = result.length;
    allTaskSink.add(allTaskLength);
  }

//🔻This week🔻

  Sink<int> get thisWeekSink => _thisWeekController.sink;
  Stream<int> get thisWeekStream => _thisWeekController.stream;
  final _thisWeekController = BehaviorSubject<int>.seeded(0);

  Future getThisWeekTask() async {
    final result = await _todoRepository.getAllTodo();
    List<Todo> thisWeekTask = result.isNotEmpty
        ? result
            .where(
              (element) => DateParser.dateDifference(
                DateParser.stringToDateTime(element.addDate),
              ),
            )
            .toList()
        : [];

    var thisWeekLength = thisWeekTask.length;

    thisWeekSink.add(thisWeekLength);
  }

//🔻Today🔻

//set & get
  Sink<int> get todaySink => _todayController.sink;
  Stream<int> get todayStream => _todayController.stream;
  final _todayController = BehaviorSubject<int>.seeded(0);

  Future getTodayTask() async {
    final result = await _todoRepository.getAllTodo();
    List<Todo> todayTask = result.isNotEmpty
        ? result
            .where((element) =>
                DateParser.stringToDateDiff(element.addDate) <
                Duration(hours: 24))
            .toList()
        : [];

    var todayTaskLength = todayTask.length;
    print('today number nah : $todayTaskLength');
    todaySink.add(todayTaskLength);
  }

  dispose() {
    _completedTaskCounterController.close();
    _allTaskController.close();
    _thisWeekController.close();
    _todayController.close();
  }
}
