import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  UserModel? user;
  bool isError = false;
  List<UserModel>? searchUsers;

  bool? isDataEmpty() {
    if (searchUsers == null) return null;
    return searchUsers!.isEmpty;
  }

  void setDataNull() {
    searchUsers = null;
    notifyListeners();
  }

  void searchUser() async {
    if (searchController.text.isEmpty) {
      return null;
    }
    String searchText = searchController.text.trim();

    if (EmailValidator.validate(searchText)) {
      searchUsers = await DatabaseRepository.searchByEmail(searchText);
    } else {
      searchUsers = await DatabaseRepository.searchByUsername(searchText);
    }

    notifyListeners();
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>>? searchByEmail() {
  //   if (searchController.text.isEmpty) {
  //     return null;
  //   }
  //   return DatabaseRepository.searchByEmail(searchController.text.trim());

  // try {
  //   UserModel? searchedUser =
  //       await DatabaseRepository.searchByEmail(searchController.text.trim());
  //   if (searchedUser != null) {
  //     log(searchedUser.toString());
  //     return searchedUser;
  //   }
  //   return null;
  // } catch (e) {
  //   throw e.toString();
  // }

  // if (searchedUser != null) {
  //   user = searchedUser;
  //   isError = false;
  //   notifyListeners();
  //   log(searchedUser.toString());
  // } else {
  //   log("No data found");
  //   isError = true;
  //   user = null;
  //   notifyListeners();
  // }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    log("Search Provider killed");
    super.dispose();
  }
}
