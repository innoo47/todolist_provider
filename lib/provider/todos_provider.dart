import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:http/http.dart' as http;

class TodosProvider with ChangeNotifier {
  final List<Todos> _todosList = List.empty(growable: true);

  List<Todos> getTodosList() {
    _fetchTodos();
    return _todosList;
  }

  void _fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    final List<Todos> result = jsonDecode(response.body)
        .map<Todos>((json) => Todos.fromJson(json))
        .toList();

    _todosList.clear();
    _todosList.addAll(result);

    notifyListeners();
  }
}
