import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/input_auth_bloc.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/pallete.dart';

showAddTodoSheet(BuildContext context) {
  final _descriptionController = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.07),
        child: Container(
          color: Pallete.inactiveColor,
          child: Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: DeviceSizeConfig.mq.viewInsets.bottom * 0.5,
            ),
            height: DeviceSizeConfig.screenHeight * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Pallete.inactiveColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 20),
              child: ListView(
                children: [
                  StreamBuilder<String>(
                    stream: Provider.of<InputAuthBloc>(context).inputStream,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'opensans',
                                fontSize: DeviceSizeConfig.longestSide * 0.025,
                              ),
                              textInputAction: TextInputAction.newline,
                              controller: _descriptionController,
                              autofocus: true,
                              maxLines: 5,
                              maxLengthEnforced: true,
                              decoration: InputDecoration(
                                  // hintText: 'I have to',
                                  labelText: 'I have to',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        DeviceSizeConfig.longestSide * 0.02,
                                  )),
                              maxLength: 50,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Pallete.activeColor,
                              radius: 18,
                              child: IconButton(
                                color: Pallete.activeColor,
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_descriptionController.text.length > 0) {
                                    final newTodo = Todo(
                                      description: _descriptionController.text,
                                      addDate: DateTime.now().toString(),
                                    );

                                    Provider.of<TodoBloc>(context,
                                            listen: false)
                                        .addTodo(newTodo);
                                    _descriptionController.clear();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
