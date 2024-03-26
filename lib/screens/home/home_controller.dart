import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/assets_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/firebaseService/firestore_service.dart';
import 'package:curd/model/item_model.dart';
import 'package:curd/utils/add_item_bottomsheet.dart';
import 'package:curd/utils/image_picker.dart';
import 'package:curd/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var isLoading = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FireStoreService _fireStoreService = FireStoreService();

  var itemList = <ItemModel>[].obs;
  var isLeadImgSelected = false.obs;
  File? imageFile;
  var imagePath = "".obs;
  var base64 = "".obs;
  var imageType = "".obs;

  late Stream<QuerySnapshot> usersStream;

  @override
  onInit() {
    super.onInit();
    usersStream = _fireStoreService.referenceToProducts
        .orderBy('createdAt', descending: true)
        .snapshots();
  }


  onTapAddItem(bool isUpdate, String? title, String? desc, id) {
    Get.bottomSheet(
      isScrollControlled: true,
      AddEditItemBottomSheet(
        titleController: titleController,
        descriptionController: descriptionController,
        title: title,
        description: desc,
        id: id,
        isEdit: isUpdate,
        formKey: formKey,
        onTap: () {
          log("Aniket");
        },
      ),
    );
  }

  captureImageFromGallery() async {
    imageFile = await PickImage.pickImageFromGallery();
    imagePath.value = imageFile!.path.toString();
    log("path: ${imagePath.value.split(".").last}");
    isLeadImgSelected.value = true;
    imageType.value = imagePath.value.split(".").last;
    final bytes = File(imageFile!.path).readAsBytesSync();
    base64.value = base64Encode(bytes);
    log("base64${base64.value}");
  }


  createItem() async {
    ItemModel model = ItemModel(title: titleController.text,
        description: descriptionController.text);
    _fireStoreService.createItems(model, imageFile).then((value) {
      clearController();
      removeImage();
      Get.back();
      FocusManager.instance.primaryFocus?.unfocus();
      ShowSnackBar().successSnackBar("Added Successfully");
    }).onError((error, stackTrace) {
      ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
    });
  }

  updateItem(id) async {
    ItemModel model = ItemModel(title: titleController.text,
        description: descriptionController.text);
    _fireStoreService.updateItems(model, imageFile, id).then((value) {
      clearController();
      removeImage();
      Get.back();
      FocusManager.instance.primaryFocus?.unfocus();
      ShowSnackBar().successSnackBar("Updated Successfully");
    }).onError((error, stackTrace) {
      ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
    });
  }


  deleteItem(id)async{
    _fireStoreService.deleteData(id).then((value) {
      ShowSnackBar().successSnackBar("Deleted Successfully");
    }).onError((error, stackTrace) {
      ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
    });
  }

  removeImage(){
    imageFile = null;
    isLeadImgSelected.value = false;
    imagePath.value = "";
  }

  clearController(){

    titleController.clear();
    descriptionController.clear();
  }

}
