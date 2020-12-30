import 'package:todo_stream/model/date_format.dart';
import 'package:todo_stream/model/todo.dart';

class DateParser {
  static List<Todo> manipulate(List<Todo> todox) {
    List<Todo> manipulatedTodo = todox
        .asMap()
        .map((i, value) => MapEntry(
            i,
            Todo(
                id: value.id,
                //add the function here
                addDate: fixIncomingDateFromDb(value.addDate),
                description: value.description,
                isDone: value.isDone)))
        .values
        .toList();

    return manipulatedTodo;
  }

  static fixIncomingDateFromDb(String date) {
    try {
      DateTime dt = DateTime.parse(date);
      String formatedDate = DateFormatModel.dateFormatter(dt);

      return formatedDate;
    } on FormatException {
      print("error message: format exception");
      return 'format error';
    }
  }
}
