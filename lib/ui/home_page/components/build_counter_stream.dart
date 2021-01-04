import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/ui/task_info/task_info.dart';

StreamBuilder<int> buildCounterStream(BuildContext context) {
  return StreamBuilder<int>(
    initialData: 0,
    stream: Provider.of<TodoBloc>(context).todoCountStream,
    builder: (context, snapshot) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, TaskInfo.id);
        },
        child: Container(
          padding: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),
          // margin: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Icon(
            Icons.info,
            size: DeviceSizeConfig.longestSide * 0.028,
            color: Pallete.activeColor,
          ),
        ),
      );
    },
  );
}
