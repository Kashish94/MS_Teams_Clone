import 'package:flutter/widgets.dart';
import 'package:teams_clone/models/user.dart';
import 'package:teams_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await AuthMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
