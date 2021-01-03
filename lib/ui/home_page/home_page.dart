import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/ui/edit_page/edit_page.dart';
import 'package:todo_stream/widget/bg_clipper.dart';

import 'components/task_list.dart';
import 'components/show_addtodo_sheet.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<TodoBloc>(context, listen: false).getTodo();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.of<TodoBloc>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceSizeConfig().init(context);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      backgroundColor: Pallete.extraInactiveColor,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10),
        child: FloatingActionButton(
          backgroundColor: Pallete.activeColor,
          elevation: 5.0,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showAddTodoSheet(context);
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.appbarColor,
        actions: [
          StreamBuilder<int>(
            initialData: 0,
            stream: Provider.of<TodoBloc>(context).todoCountStream,
            builder: (context, snapshot) {
              return Container(
                margin:
                    EdgeInsets.only(right: DeviceSizeConfig.screenWidth * 0),
                width: DeviceSizeConfig.screenHeight * 0.08,
                padding: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Pallete.extraInactiveColor,
                  shape: BoxShape.rectangle,
                ),
                // margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'opensans',
                      color: Pallete.activeColor),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Pallete.extraInactiveColor,
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('search button pressed');

                showSearch(
                  context: context,
                  delegate: CustomDelegate(),
                );
              },
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            //TODO: open drawer
          },
        ),
        title: Text(
          "Tasks",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'opensans',
              fontStyle: FontStyle.normal,
              fontSize: 19),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    color: Pallete.backgroundColor,
                  ),
                ),
              ),
              taskList(context),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate<Todo> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.white,
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: Provider.of<TodoBloc>(context, listen: true).todos,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('seaerch something else');
        }

        return ListTile(
          leading: Text('leading'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //suggestuion while the user types

    return StreamBuilder<List<Todo>>(
      stream: Provider.of<TodoBloc>(context, listen: true).todos,
      builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No data',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final results = snapshot.data.where(
            (element) => element.description.toLowerCase().contains(query));

        return ListView(
          children: results
              .map<Widget>(
                (e) => GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, EditPage.id, arguments: e),
                  child: Card(
                    color: Pallete.inactiveColor,
                    child: ListTile(
                      title: Text(e.description),
                      subtitle: Text(e.addDate),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

//  Card(
//                         color: todo.isDone
//                             ? Pallete.activeColor
//                             : Pallete.inactiveColor,
//                         margin: EdgeInsets.only(
//                           top: index == 0 ? 15 : 9,
//                           bottom: 9,
//                           left: 10,
//                           right: 10,
//                         ),
//                         elevation: 7,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: ListTile(
//                           subtitle: StreamBuilder<Object>(
//                               stream: DateParser.dateStream(todo.addDate),
//                               initialData: '0',
//                               builder: (context, snapshot) {
//                                 return Text(
//                                   // DateParser.fixIncomingDateFromDb(todo.addDate)
//                                   snapshot.data.toString(),
//                                   style: TextStyle(
//                                     fontSize:
//                                         DeviceSizeConfig.longestSide * 0.02,
//                                     fontFamily: 'opensans',
//                                     fontWeight: FontWeight.w600,
//                                     color: todo.isDone
//                                         ? Colors.white70
//                                         : Colors.blueGrey,
//                                   ),
//                                 );
//                               }),
//                           leading: GestureDetector(
//                             onTap: () {
//                               todo.isDone = !todo.isDone;

//                               Provider.of<TodoBloc>(context, listen: false)
//                                   .updateTodo(todo);
//                             },
//                             child: Container(
//                               child: customWidget(isDone: todo.isDone),
//                             ),
//                           ),
//                           trailing: IconButton(
//                             tooltip: 'Delete',
//                             icon: Icon(
//                               Icons.cancel_outlined,
//                               color: todo.isDone
//                                   ? Color(0xFF242433)
//                                   : Color(0xFF38BA6C),
//                             ),
//                             onPressed: () =>
//                                 Provider.of<TodoBloc>(context, listen: false)
//                                     .deleteTodo(todo.id),
//                           ),
//                           title: Text(
//                             snapshot.data[index].description,
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               fontSize: DeviceSizeConfig.longestSide * 0.03,
//                               color: todo.isDone
//                                   ? Colors.white
//                                   : Color(0xFF38BA6C),
//                               decoration: todo.isDone
//                                   ? TextDecoration.lineThrough
//                                   : null,
//                               fontFamily: 'opensans',
//                             ),
//                           ),
//                         ),
//                       ),
