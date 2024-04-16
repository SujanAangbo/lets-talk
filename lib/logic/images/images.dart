import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Images {
  Future<XFile?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    return pickedImage;
  }

  Future<File?> cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}
