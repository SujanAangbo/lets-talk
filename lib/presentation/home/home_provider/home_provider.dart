import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  int _index = 0;

  get index => _index;

  void changePage(int index) {
    _index = index;
    notifyListeners();
  }
}
