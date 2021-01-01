import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/pallete.dart';
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
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
