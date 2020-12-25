import 'package:intl/intl.dart';

import 'date_format.dart';

class Todo {
  final int id;
  final String description;
  bool isDone = false;
  String addDate;

  Todo({
    this.id,
    this.description,
    this.isDone = false,
    this.addDate,
  });

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'description': description,
      'is_done': this.isDone == false ? 0 : 1,
      'dateadd': this.addDate.toString(),
    };
  }

  factory Todo.fromDatabase(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      id: map['id'],
      description: map['description'],
      isDone: map['is_done'] == 0 ? false : true,
      addDate: formatDate(map['dateadd']),
    );
  }

//Format date from database
  static String formatDate(String dateValue) {
    DateTime createdDate = DateTime.parse(dateValue);
    DateFormatModel _dateFormatModel = DateFormatModel();
    var result = _dateFormatModel.dateFormatter(createdDate);
    return result;
    // Duration dateDiff = DateTime.now().difference(createdDate);
    // print(dateDiff);
    // var newFormat = DateFormat("HH:MM-dd");
    // return newFormat.format(createdDate).toString();
  }
}

//format date to db

//current date - created date => (DATETIME -DATETIME ONLY)
