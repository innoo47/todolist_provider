import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TodosProvider with ChangeNotifier {
  final List<Todos> _todosList = List.empty(growable: true);
  final _todoStreamController = StreamController<List<Todos>>.broadcast();

  Stream<List<Todos>> get todosStream => _todoStreamController.stream;

  Future<void> fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

      if (response.statusCode == 200) {
        final List<Todos> result = jsonDecode(response.body)
            .map<Todos>((json) => Todos.fromJson(json))
            .toList();

        _todosList.clear();
        _todosList.addAll(result);

        _todoStreamController.add(_todosList);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _todoStreamController.close();
    super.dispose();
  }
}
