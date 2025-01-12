import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/provider/login_provider.dart';
import 'package:todolist_provider/provider/todos_provider.dart';
import 'package:todolist_provider/view/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TodosProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
