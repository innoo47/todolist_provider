import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/provider/todos_provider.dart';
import 'package:todolist_provider/view/todos_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<TodosProvider>(
        create: (context) => TodosProvider(),
        child: const TodosView(),
      ),
    );
  }
}
