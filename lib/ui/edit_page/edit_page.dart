import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/input_auth_bloc.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/widget/bg_clipper.dart';

class EditPage extends StatefulWidget {
  static String id = 'editPage';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController textController = TextEditingController();
  Todo todo;

  @override
  void didChangeDependencies() {
    todo = ModalRoute.of(context).settings.arguments;
    textController.text = todo.description;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0XEB222231),
      appBar: AppBar(
        backgroundColor: Pallete.activeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (textController.text.isNotEmpty) {
              todo.description = textController.text;
              Provider.of<TodoBloc>(context, listen: false).updateTodo(todo);
              Navigator.pop(context);
            }
            if (textController.text.isEmpty) {
              Provider.of<TodoBloc>(context, listen: false).deleteTodo(todo.id);
              Navigator.pop(context);
            }
          },
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
                    padding: EdgeInsets.symmetric(
                      horizontal: DeviceSizeConfig.screenHeight * 0.03,
                      vertical: DeviceSizeConfig.screenWidth * 0.02,
                    ),
                    color: Color(0XFF222231),
                    child: StreamBuilder<String>(
                        stream: Provider.of<InputAuthBloc>(context).inputStream,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return Column(
                            children: [
                              TextField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        DeviceSizeConfig.longestSide * 0.025,
                                    fontFamily: 'opensans'),
                                controller: textController,
                                onChanged: (value) {
                                  Provider.of<InputAuthBloc>(context,
                                          listen: false)
                                      .inputSink
                                      .add(textController.text);
                                },
                                maxLines: 5,
                                maxLength: 50,
                                maxLengthEnforced: true,
                                decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                ),
                              ),
                              FlatButton(
                                color: Pallete.activeColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      DeviceSizeConfig.longestSide * 0.01),
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        fontFamily: 'opensans',
                                        fontSize: DeviceSizeConfig.longestSide *
                                            0.03),
                                  ),
                                ),
                                onPressed: !snapshot.hasError
                                    ? () {
                                        if (textController.text.isNotEmpty) {
                                          todo.description =
                                              textController.text;
                                          Provider.of<TodoBloc>(context,
                                                  listen: false)
                                              .updateTodo(todo);
                                          Navigator.pop(context);
                                        }
                                        if (textController.text.isEmpty) {
                                          Provider.of<TodoBloc>(context,
                                                  listen: false)
                                              .deleteTodo(todo.id);
                                          Navigator.pop(context);
                                        }
                                      }
                                    : null,
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
