import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/todo_bloc.dart';
import 'package:todo_stream/model/todo.dart';
import 'package:todo_stream/pallete.dart';
import 'package:todo_stream/ui/edit_page/edit_page.dart';
import 'buildIconButton.dart';

class CustomDelegate extends SearchDelegate<Todo> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      buildIconButton(
        color: Colors.white,
        icon: Icon(Icons.cancel),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return buildIconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
        color: Colors.white);
  }

  @override
  Widget buildResults(BuildContext context) {
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

        final results = snapshot.data.where((element) =>
            element.description.toLowerCase().contains(query.toLowerCase()));

        return ListView(
          children: results
              .map<Widget>(
                (e) => Card(
                  color: Pallete.inactiveColor,
                  child: ListTile(
                    title: Text(
                      e.description,
                    ),
                    subtitle: Text(e.addDate),
                    onTap: () {
//TODO: dont know what to add anymore
//TODO: Navigate to edit page to edit the result

                      Navigator.pushNamed(context, EditPage.id, arguments: e);
                    },
                  ),
                ),
              )
              .toList(),
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

        final results = snapshot.data.where((element) =>
            element.description.toLowerCase().contains(query.toLowerCase()));

        if (results.length < 0) {
          return Text(
            'No result',
            style: TextStyle(
              color: Colors.white,
            ),
          );
        }

        return ListView(
          children: results
              .map<Widget>(
                (e) => Card(
                  color: Pallete.inactiveColor,
                  child: ListTile(
                    title: Text(
                      e.description,
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    subtitle: Text(e.addDate),
                    onTap: () {
                      query = e.description;
                      Navigator.pushNamed(context, EditPage.id, arguments: e);
                    },
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
