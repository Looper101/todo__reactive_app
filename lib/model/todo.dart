class Todo {
  int id;
  String description;
  bool isDone = false;

  Todo({
    this.id,
    this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'description': description,
      'is_done': this.isDone == false ? 0 : 1,
    };
  }

  factory Todo.fromDatabase(Map<String, dynamic> map) {
    if (map == null) return null;

    return Todo(
      id: map['id'],
      description: map['description'],
      isDone: map['is_done'] == 0 ? false : true,
    );
  }
}
