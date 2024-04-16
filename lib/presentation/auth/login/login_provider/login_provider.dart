import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';

import '../../../../data/repository/auth_repository.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormState = GlobalKey();

  AuthRepository auth = AuthRepository();
  DatabaseRepository database = DatabaseRepository();

  LoginProvider() {
    log("Login Provider Created");
  }

  Future<UserModel?> login(BuildContext context) async {
    if (loginFormState.currentState!.validate()) {
      UIHelper.showLoader(context, "Logging in...");
      try {
        UserModel? user = await auth.login(
            email: emailController.text, password: passwordController.text);
        return user;
      } on FirebaseException catch (e) {
        UIHelper.showSnackbar(context, e.message.toString(), Colors.red);
        Navigator.pop(context);
        return null;
      }
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    loginFormState.currentState?.dispose();
    log("Login provider destroyed");
    super.dispose();
  }
}
