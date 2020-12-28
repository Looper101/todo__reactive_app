import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';

// import 'package:todo_stream/database/database.dart';
import 'components/get_todo_widget.dart';
import 'components/show_addtodo_sheet.dart';

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

  @override
  void didChangeDependencies() {
    Provider.of<TodoBloc>(context, listen: false).getTodo();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.green.shade900,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          elevation: 5.0,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showAddTodoSheet(context);
          },
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey,
        actions: [
          StreamBuilder<int>(
            initialData: 0,
            stream: Provider.of<TodoBloc>(context).todoCountStream,
            builder: (context, snapshot) {
              return Container(
                width: 45,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                // margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            //just re-pull UI for testing purposes
            // Provider.of<TodoBloc>(context, listen: false).clearDb();
            // Provider.of<TodoBloc>(context, listen: false).getTodo();
          },
        ),
        title: Text(
          "Taskie",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'RobotoMono',
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
                    child: Container(color: Colors.grey)),
              ),
              getTodosWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path();

    path1
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.88, size.height)
      ..lineTo(size.width * 0.8, size.height * 0.9)
      // ..quadraticBezierTo(
      //     size.width * 0.92, size.height * 0.85, size.width, size.height * 0.78)
      ..lineTo(size.width, size.height * .85)
      ..lineTo(size.width, 0)
      ..close();
    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
