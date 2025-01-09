import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TodosProvider with ChangeNotifier {
  final List<Todos> _todosList =
      List.empty(growable: true); // List를 생성하고 빈 리스트로 초기화 (리스트의 크기가 증가 가능)
  final _todoStreamController = StreamController<
      List<Todos>>.broadcast(); // StreamController를 생성하고 브로드캐스트로 설정

  Stream<List<Todos>> get todosStream =>
      _todoStreamController.stream; // Stream을 반환하는 getter

  List<Todos> getTodosList() {
    _fetchTodos(); // fetchTodos 메서드를 호출
    return _todosList; // _todosList를 반환
  }

  // fetchTodos 메서드를 생성
  Future<void> _fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

      if (response.statusCode == 200) {
        final List<Todos> result = jsonDecode(response.body)
            .map<Todos>((json) => Todos.fromJson(json))
            .toList();

        _todosList.clear();
        _todosList.addAll(result);

        _todoStreamController.add(_todosList); // Stream에 데이터를 추가
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // dispose 메서드를 오버라이드하고 StreamController를 닫음
    _todoStreamController.close();
    super.dispose();
  }
}
