import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/auth_repository.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  GlobalKey<FormState> signUpFormState = GlobalKey();
  AuthRepository auth = AuthRepository();

  SignUpProvider() {
    log("Sign up provider created");
  }

  Future<UserModel?> signUp(BuildContext context) async {
    if (signUpFormState.currentState!.validate()) {
      UIHelper.showLoader(context, "Signing up...");
      try {
        UserModel? signUpUser = await auth.signUp(
            email: emailController.text, password: passwordController.text);

        return signUpUser;
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        UIHelper.showSnackbar(context, e.message.toString(), Colors.red);
      }

      // do the task after login
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    signUpFormState.currentState?.dispose();
    log("Sign up provider destroyed");
    super.dispose();
  }
}
