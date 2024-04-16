import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_chat/data/models/user_model.dart';

/// this class is used to perform operation on firebase firestore.
class DatabaseRepository {
  static final database = FirebaseFirestore.instance;

  static Future<void> saveUserData(UserModel user) async {
    try {
      await database.collection('users').doc(user.uid).set(user.toMap());
      log('Data saved to database');
    } on FirebaseException {
      rethrow;
    }
  }

  /// This function is used to search user by email.
  /// First it will search for the email passed in the firebase firestore
  /// then if the user exists with that email, it will return that user
  static Future<List<UserModel>> searchByEmail(String email) async {
    try {
      QuerySnapshot dataSnapshot = await database
          .collection('users')
          .where("email", isEqualTo: email)
          .where('email',
              isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      return dataSnapshot.docs.map((field) {
        final userMap = field.data() as Map<String, dynamic>;
        return UserModel.fromMap(userMap);
      }).toList();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<UserModel>> searchByUsername(String username) async {
    try {
      QuerySnapshot dataSnapshot = await database
          .collection('users')
          .where("name", isEqualTo: username)
          .where('email',
              isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      return dataSnapshot.docs.map((field) {
        final userMap = field.data() as Map<String, dynamic>;
        return UserModel.fromMap(userMap);
      }).toList();
    } on FirebaseException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await database.collection('users').doc(uid).get();
      Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;

      // parse map to UserModel
      UserModel loggedInUser = UserModel.fromMap(userMap);
      log("Data retrieved from firebase");
      return loggedInUser;
    } on FirebaseException {
      log("Problem while getting user data");
      rethrow;
    }
  }
}
