import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/widget/bg_clipper.dart';

import 'components/get_todo_widget.dart';
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
        backgroundColor: Pallete.inactiveColor,
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

                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(5),
                  //   bottomLeft: Radius.circular(0),
                  // ),
                ),
                // margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 20, fontFamily: 'opensans'),
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
          "Arranger",
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
                      color: Color(0XFF222231),
                    )),
              ),
              getTodosWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
