import 'package:flutter/material.dart';
import 'package:todolist_provider/view/todos_view.dart';
import 'package:todolist_provider/view/login_view.dart';

class LoginProvider with ChangeNotifier {
  late String userId; // userId을 non-nullable 변수로 만들기 위해 late를 사용
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login(BuildContext context, String value) {
    print('login_userId : $value');
    userId = value;
    _isLoggedIn = true;
    notifyListeners();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const TodosView(),
      ),
    );
  }

  void logout(BuildContext context) {
    _isLoggedIn = false;
    notifyListeners();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  String? validator(String? value) {
    final intValue = int.tryParse(value!);
    if (intValue! > 0 && intValue < 11) {
      return null;
    } else {
      return '숫자는 1부터 10 사이여야 합니다';
    }
  }
}
