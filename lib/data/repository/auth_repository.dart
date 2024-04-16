import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_page.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // BuildContext context;
  // AuthRepository(this.context);

  /// It is used to create user and returns the UserModel with uid, email, createdOn property.
  /// Otherwise it will return null.
  Future<UserModel?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('User logged in');
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        createdOn: DateTime.now().toIso8601String(),
      );
      await DatabaseRepository.saveUserData(newUser);
      print('outside db');
      return newUser;
    } on FirebaseException {
      rethrow;
    }
  }

  /// this function is used to logged in the user and get the uid from the credential.
  /// By using it it will fetch users data from the firebase firestore and returns UserModel(user data).
  /// if there is any error it will return null
  Future<UserModel?> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('User logged in');

      if (userCredential.user == null) {
        return null;
      } else {
        String uid = userCredential.user!.uid;
        UserModel? user = await DatabaseRepository.getUserData(uid);

        return user;
      }
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
