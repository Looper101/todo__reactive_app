import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
// import 'package:todo_stream/database/database.dart';
import 'package:todo_stream/model/todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TodoBloc todoBloc;
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 10.0,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            _showAddTodoSheet(context);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.indigoAccent,
                    size: 28,
                  ),
                  onPressed: () {
                    //just re-pull UI for testing purposes
                    Provider.of<TodoBloc>(context, listen: false).getTodo();
                  }),
              Text(
                "Todo",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                    fontStyle: FontStyle.normal,
                    fontSize: 19),
              ),
              Wrap(children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.indigoAccent,
                  ),
                  onPressed: () {
                    // _showTodoSearchSheet(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                )
              ])
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: getTodosWidget(),
        ),
      ),
    );
  }

  Widget getTodosWidget() {
    return StreamBuilder<List<Todo>>(
      stream: Provider.of<TodoBloc>(context).todos,
      builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var data = snapshot.data[index];
              return Dismissible(
                background: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                key: GlobalKey(),
                onDismissed: (direction) {
                  if (direction == DismissDirection.horizontal) {
                    Provider.of<TodoBloc>(context, listen: false)
                        .deleteTodo(index);
                  }
                },
                child: ListTile(
                  leading: Checkbox(
                    onChanged: (value) {},
                    value: data.isDone,
                  ),
                  title: Text(snapshot.data[index].description),
                ),
              );
            },
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text(
              snapshot.data.runtimeType.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _showAddTodoSheet(BuildContext context) {
    final _descriptionController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber,
          height: 230,
          width: double.infinity,
          child: ListView(
            children: [
              TextFormField(
                controller: _descriptionController,
                autofocus: true,
                maxLines: 5,
                decoration: InputDecoration(hintText: 'I have to'),
                validator: (value) {
                  return value == null ? 'empty description' : null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 15),
                child: CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  radius: 18,
                  child: IconButton(
                    icon: Icon(
                      Icons.save,
                      size: 22,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_descriptionController.text != null) {
                        final newTodo = Todo(
                          description: _descriptionController.text,
                        );

                        Provider.of<TodoBloc>(context, listen: false)
                            .addTodo(newTodo);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
