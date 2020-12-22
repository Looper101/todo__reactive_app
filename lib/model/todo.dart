import 'dart:convert';

class Todo {
  int id;
  String description;
  bool isDone = false;
  Todo({
    this.id,
    this.description,
    this.isDone,
  });

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Todo.fromDatabase(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      id: map['id'],
      description: map['description'],
      isDone: map['isDone'],
    );
  }
}
