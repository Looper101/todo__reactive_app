import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stream/bloc/input_auth_bloc.dart';
import 'package:todo_stream/ui/homepage.dart';

import 'bloc/todo_bloc.dart';
import 'ui/editpage/edit_page.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.green),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          EditPage.id: (context) => EditPage(),
        },
      ),
    );
  }
}
