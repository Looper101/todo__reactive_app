import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/model/todo.dart';

Widget getTodosWidget(BuildContext context) {
  return StreamBuilder<List<Todo>>(
    stream: Provider.of<TodoBloc>(context).todos,
    builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
      List<Todo> todoList = snapshot.data;

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.hasData) {
        return snapshot.data.length != 0
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Todo todo = snapshot.data[index];

                  return Dismissible(
                    background: Container(
                      padding: EdgeInsets.only(left: 10),
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 10),
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    key: ObjectKey(todo),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd ||
                          direction == DismissDirection.endToStart) {
                        Provider.of<TodoBloc>(context, listen: false)
                            .deleteTodo(todo.id);
                      }
                      return null;
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        subtitle: Text(todo.addDate,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        leading: GestureDetector(
                          onTap: () {
                            todo.isDone = !todo.isDone;

                            Provider.of<TodoBloc>(context, listen: false)
                                .updateTodo(todo);
                          },
                          child: Container(
                            child: todo.isDone
                                ? Icon(Icons.done)
                                : Icon(Icons.check_box_outline_blank),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              Provider.of<TodoBloc>(context, listen: false)
                                  .deleteTodo(todo.id),
                        ),
                        title: Text(
                          snapshot.data[index].description,
                          style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'Add todo',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              );
      } else {
        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text(
                'Loading todo',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        );
      }
    },
  );
}
