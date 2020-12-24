import 'date_format.dart';

class Todo {
  final int id;
 final  String description;
   bool isDone = false;
   String dateAdded = DateTime.now().toString();

  Todo({
    this.id,
    this.description,
    this.isDone = false,
    this.dateAdded ,
  });

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'description': description,
      'is_done': this.isDone == false ? 0 : 1,
      'dateAdded': this.dateAdded,
    };
  }

  factory Todo.fromDatabase(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      id: map['id'],
      description: map['description'],
      isDone: map['is_done'] == 0 ? false : true,
      dateAdded: DateFormatModel.formatDate(map['dateAdded']);
    );
  }
}
