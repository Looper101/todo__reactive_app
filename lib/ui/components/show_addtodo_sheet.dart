import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/model/todo.dart';

showAddTodoSheet(BuildContext context) {
  final _descriptionController = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.transparent,
          child: Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 30),
              child: ListView(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          textInputAction: TextInputAction.newline,
                          controller: _descriptionController,
                          autofocus: true,
                          maxLines: 5,
                          decoration: InputDecoration(
                              // hintText: 'I have to',
                              labelText: 'i have to',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return value == null ? 'empty description' : null;
                          },
                        ),
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
                              if (_descriptionController.text.length >= 0) {
                                final newTodo = Todo(
                                  description: _descriptionController.text,
                                );

                                Provider.of<TodoBloc>(context, listen: false)
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
