import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfilePicture(String uid, File file) async {
    try {
      print('Inside storage');

      TaskSnapshot snapshot =
          await _storage.ref("profile_image").child('$uid.jpg').putFile(file);
      print('upload completed');
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    } on FirebaseException {
      rethrow;
    }
  }
}
