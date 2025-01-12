import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:todolist_provider/provider/login_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TodosProvider with ChangeNotifier {
  final LoginProvider loginProvider; // LoginProvider를 받아옴
  final List<Todos> _todosList =
      List.empty(growable: true); // List를 생성하고 빈 리스트로 초기화 (리스트의 크기가 증가 가능)
  final _todoStreamController = StreamController<
      List<Todos>>.broadcast(); // StreamController를 생성하고 브로드캐스트로 설정

  TodosProvider(this.loginProvider); // 생성자에서 LoginProvider를 주입받음

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
        _todosList.addAll(result.where(
            (result) => result.userId == int.parse(loginProvider.userId!)));
        print(_todosList);

        _todoStreamController.add(_todosList); // Stream에 데이터를 추가
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print(e);
    }

    notifyListeners(); // 변경 사항을 알림
  }

  @override
  void dispose() {
    // dispose 메서드를 오버라이드하고 StreamController를 닫음
    _todoStreamController.close();
    super.dispose();
  }
}
