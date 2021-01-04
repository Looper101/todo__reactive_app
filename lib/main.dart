import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/ui/edit_page/edit_page.dart';
import 'package:todo_stream/ui/home_page/home_page.dart';
import 'package:todo_stream/ui/task_info/task_info.dart';

import 'bloc/input_auth_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => TodoBloc()),
        Provider(create: (context) => InputAuthBloc()),
        Provider(create: (context) => TaskCounterBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.green),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          EditPage.id: (context) => EditPage(),
          TaskInfo.id: (context) => TaskInfo()
        },
      ),
    );
  }
}
