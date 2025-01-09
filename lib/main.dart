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
    // 변경 사항을 알려야 하므로 ChangeNotifierProvider를 사용
    return ChangeNotifierProvider<TodosProvider>(
      create: (context) => TodosProvider(),
      child: const MaterialApp(
        home: TodosView(),
      ),
    );
  }
}
