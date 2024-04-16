import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:lets_chat/data/repository/storage_repository.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';

import '../../../../logic/images/images.dart';

class CompleteProfileProvider with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  File? profileImage;
  GlobalKey<FormState> profileState = GlobalKey();

  // bool? isImagePicked;
  String? errorMessage;

  CompleteProfileProvider() {
    log("Complete profile provider created");
  }

  StorageRepository storage = StorageRepository();
  DatabaseRepository database = DatabaseRepository();

  Future<void> pickProfilePicture() async {
    final image = Images();
    XFile? pickedFile = await image.pickImage(ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = await image.cropImage(pickedFile.path);
      if (profileImage != null) {
        errorMessage = null;
        notifyListeners();
      }
    }
  }

  Future<String?> uploadProfilePicture(String uid, File file) async {
    try {
      String? downloadUrl = await storage.uploadProfilePicture(uid, file);
      return downloadUrl;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<bool> updateProfile(BuildContext context, UserModel oldData) async {
    // only update if the profile and username is not empty
    if (profileState.currentState!.validate() && profileImage != null) {
      errorMessage = null;
      notifyListeners();

      // update or add new username
      oldData.name = usernameController.text;

      UIHelper.showLoader(context, "Uploading images...");

      try {
        // upload the profile picture to the firebase storage and get its downloadable link
        final profilePicLink =
            await uploadProfilePicture(oldData.uid!, profileImage!);

        Navigator.pop(context);
        UIHelper.showLoader(context, "Updating your data..");

        if (profilePicLink == null) {
          errorMessage = "Unable to upload image";
          notifyListeners();
        } else {
          // add downloadable link to usermodel and save it to firebase firestore
          oldData.profile = profilePicLink;
          await DatabaseRepository.saveUserData(oldData);
          print('Successfully updated user details');

          return true;
        }
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        UIHelper.showSnackbar(context, e.message.toString(), Colors.red);
      }
    } else if (profileImage == null) {
      errorMessage = "Please select profile picture";
      notifyListeners();
    } else {
      log('Something went wrong');
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log("Complete profile provider destroyed");
    super.dispose();
  }
}
