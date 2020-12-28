import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/model/date_parser.dart';
import 'package:todo_stream/model/todo.dart';

Widget getTodosWidget(BuildContext context) {
  return StreamBuilder<List<Todo>>(
    stream: Provider.of<TodoBloc>(context).todos,
    builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.hasData) {
        return snapshot.data.isNotEmpty
            ? ListView.builder(
                itemCount: 0 + snapshot.data.length,
                itemBuilder: (context, index) {
                  Todo todo = snapshot.data[index];

                  return Dismissible(
                    background: Container(
                      padding: EdgeInsets.only(left: 10),
                      color: Colors.grey,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 10),
                      color: Colors.grey,
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
                      color: Colors.grey.shade800,
                      margin: EdgeInsets.only(
                        top: index == 0 ? 15 : 9,
                        bottom: 9,
                        left: 3,
                        right: 3,
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        subtitle: Text(
                          DateParser.fixIncomingDateFromDb(todo.addDate),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        leading: GestureDetector(
                          onTap: () {
                            todo.isDone = !todo.isDone;

                            Provider.of<TodoBloc>(context, listen: false)
                                .updateTodo(todo);
                          },
                          child: Container(
                            child: customWidget(isDone: todo.isDone),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.green.withOpacity(0.8),
                          ),
                          onPressed: () =>
                              Provider.of<TodoBloc>(context, listen: false)
                                  .deleteTodo(todo.id),
                        ),
                        title: Text(
                          snapshot.data[index].description,
                          style: TextStyle(
                              color: !todo.isDone
                                  ? Colors.blueGrey.shade300
                                  : Colors.green,
                              fontSize: 20,
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
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
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

//TODO: ADD DATE STREAM IMPLEMEMATTION   Provider.of<TodoBloc>(context, listen: false).getTodo();

Widget customWidget({bool isDone}) {
  return AnimatedContainer(
    curve: Curves.bounceInOut,
    duration: Duration(seconds: 3),
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      color: !isDone ? Colors.white : Colors.green,
      shape: BoxShape.circle,
      border: Border.all(
        color: isDone ? Colors.green : Colors.blueGrey,
        width: 5,
      ),
    ),
  );
}
