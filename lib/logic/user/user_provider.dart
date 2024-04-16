import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  get getUser => _user;

  void setUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }
}
