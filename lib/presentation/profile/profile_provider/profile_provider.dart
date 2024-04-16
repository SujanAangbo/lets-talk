import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:lets_chat/presentation/message/message_provider/message_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/repository/auth_repository.dart';

class ProfileProvider with ChangeNotifier {
  AuthRepository auth = AuthRepository();

  UserModel? user;

  bool isLoading() {
    if (user == null) return true;
    return false;
  }

  ProfileProvider() {
    getUserData();
  }

  void getUserData() async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    user = await DatabaseRepository.getUserData(myUid);
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    auth.logout();
  }
}
