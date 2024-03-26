import 'dart:io';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/utils/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static pickImageFromGallery() async {
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    } else {
      ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
    }
  }

  static captureImageFromCamera() async {
    final XFile? photo =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo != null) {
      File imageFile = File(photo.path);
      return imageFile;
    } else {
      ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
    }
  }


}