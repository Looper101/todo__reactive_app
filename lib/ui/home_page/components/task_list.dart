import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/model/date_parser.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/ui/edit_page/edit_page.dart';

Widget taskList(BuildContext context) {
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
                      color: Colors.blueGrey.withOpacity(0.4),
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 10),
                      color: Colors.blueGrey.withOpacity(0.4),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    key: ObjectKey(todo),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      //either of the direction will trigger this
                      if (direction == DismissDirection.startToEnd ||
                          direction == DismissDirection.endToStart) {
                        Provider.of<TodoBloc>(context, listen: false)
                            .deleteTodo(todo.id);
                      }
                      return null;
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, EditPage.id,
                          arguments: todo),
                      child: Card(
                        color: todo.isDone
                            ? Pallete.activeColor
                            : Pallete.inactiveColor,
                        margin: EdgeInsets.only(
                          top: index == 0 ? 15 : 9,
                          bottom: 9,
                          left: 10,
                          right: 10,
                        ),
                        elevation: 7,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          subtitle: StreamBuilder<Object>(
                              stream: DateParser.dateStream(todo.addDate),
                              initialData: '0',
                              builder: (context, snapshot) {
                                return Text(
                                  // DateParser.fixIncomingDateFromDb(todo.addDate)
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    fontSize:
                                        DeviceSizeConfig.longestSide * 0.02,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w600,
                                    color: todo.isDone
                                        ? Colors.white70
                                        : Colors.blueGrey,
                                  ),
                                );
                              }),
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
                            tooltip: 'Delete',
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: todo.isDone
                                  ? Color(0xFF242433)
                                  : Color(0xFF38BA6C),
                            ),
                            onPressed: () =>
                                Provider.of<TodoBloc>(context, listen: false)
                                    .deleteTodo(todo.id),
                          ),
                          title: Text(
                            snapshot.data[index].description,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: DeviceSizeConfig.longestSide * 0.03,
                              color: todo.isDone
                                  ? Colors.white
                                  : Color(0xFF38BA6C),
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontFamily: 'opensans',
                            ),
                          ),
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
                      color: Pallete.activeColor),
                ),
              );
      } else {
        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(
                backgroundColor: Pallete.activeColor,
              ),
              Text(
                'Loading todo',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Pallete.activeColor),
              ),
            ],
          ),
        );
      }
    },
  );
}

Widget customWidget({bool isDone}) {
  return AnimatedContainer(
    curve: Curves.elasticInOut,
    duration: Duration(milliseconds: 250),
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      color: !isDone ? Colors.white : Color(0xFF38BA6C),
      shape: BoxShape.circle,
      border: Border.all(
        color: isDone ? Colors.green : Color(0xFF788597),
        width: 5,
      ),
    ),
  );
}
