import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/widget/bg_clipper.dart';
import 'package:todo_stream/widget/buildIconButton.dart';
import 'package:todo_stream/widget/search_delegate.dart';
import 'components/build_counter_stream.dart';
import 'components/build_cupertino_button.dart';
import 'components/task_list.dart';
import 'components/show_addtodo_sheet.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoBloc>(context, listen: false).getTodo();
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
      drawer: Drawer(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Pallete.appbarColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDrawerButton(
                  title: 'Reset App',
                  onPress: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return Platform.isIOS
                            ? CupertinoAlertDialog(
                                title: Column(
                                  children: [
                                    Text('Reset App?'),
                                    Divider(),
                                    Text(
                                      'These action will delete every task ',
                                      style: TextStyle(
                                          fontSize:
                                              DeviceSizeConfig.longestSide *
                                                  0.022),
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoButton(
                                    color: Pallete.inactiveColor,
                                    onPressed: () {
                                      Provider.of<TodoBloc>(context,
                                              listen: false)
                                          .clearDb();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  CupertinoButton(
                                    color: Pallete.inactiveColor,
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('No'),
                                  ),
                                ],
                              )
                            : AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Pallete.backgroundColor,
                                title: Column(
                                  children: [
                                    Text(
                                      'Reset App?',
                                      style: TextStyle(
                                          fontSize:
                                              DeviceSizeConfig.longestSide *
                                                  0.022,
                                          fontFamily: 'opensans'),
                                    ),
                                    Divider(),
                                    Text(
                                      'These action will delete every task',
                                      style: TextStyle(
                                          fontSize:
                                              DeviceSizeConfig.longestSide *
                                                  0.022,
                                          fontFamily: 'opensans'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoButton(
                                    color: Pallete.warning,
                                    onPressed: () {
                                      Provider.of<TodoBloc>(context,
                                              listen: false)
                                          .clearDb();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize:
                                              DeviceSizeConfig.longestSide *
                                                  0.022,
                                          fontFamily: 'opensans'),
                                    ),
                                  ),
                                  CupertinoButton(
                                    color: Pallete.activeColor,
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('No'),
                                  ),
                                ],
                              );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: DeviceSizeConfig.screenHeight * 0.03,
                ),
                buildDrawerButton(
                  title: 'Exit app',
                  onPress: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Platform.isIOS
                          ? CupertinoAlertDialog(
                              title: Column(
                                children: [
                                  Text('Exit App'),
                                  Text(
                                    'This action will close the app',
                                    style: TextStyle(
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.022,
                                        fontFamily: 'opensans'),
                                  ),
                                ],
                              ),
                              actions: [
                                CupertinoButton(
                                  color: Pallete.warning,
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.022,
                                        fontFamily: 'opensans'),
                                  ),
                                  onPressed: () => SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop'),
                                ),
                                CupertinoButton(
                                  color: Pallete.inactiveColor,
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.022,
                                        fontFamily: 'opensans'),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )
                          : AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Pallete.backgroundColor,
                              title: Column(
                                children: [
                                  Text('Exit App'),
                                ],
                              ),
                              content: Text(
                                'This action will close the app',
                                style: TextStyle(
                                    fontSize:
                                        DeviceSizeConfig.longestSide * 0.022,
                                    fontFamily: 'opensans'),
                              ),
                              actions: [
                                CupertinoButton(
                                  color: Pallete.warning,
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.022,
                                        fontFamily: 'opensans'),
                                  ),
                                  onPressed: () => SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop'),
                                ),
                                CupertinoButton(
                                  color: Pallete.activeColor,
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.022,
                                        fontFamily: 'opensans'),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.appbarColor,
        actions: [
          buildCounterStream(context),
          SizedBox(
            width: DeviceSizeConfig.screenWidth * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: buildIconButton(
              color: Colors.red,
              onPressed: () => showSearch(
                context: context,
                delegate: CustomDelegate(),
              ),
              context: context,
              icon: Icon(Icons.search),
            ),
          ),
        ],
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
