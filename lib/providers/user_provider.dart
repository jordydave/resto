import 'package:flutter/material.dart';
import 'package:submission_2_restaurant_dicoding/models/user_model.dart';
import 'package:submission_2_restaurant_dicoding/services/user_service.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      User user = await UserService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      User user = await UserService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
