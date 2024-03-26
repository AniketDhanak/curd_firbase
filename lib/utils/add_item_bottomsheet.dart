import 'dart:developer';

import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/assets_constants.dart';
import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditItemBottomSheet extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? title;
  final String? description;
  final dynamic id;
  final bool isEdit;
  final GlobalKey<FormState> formKey;
  final Function()? onTap;

  const AddEditItemBottomSheet(
      {super.key,
      required this.titleController,
      required this.descriptionController,
      required this.isEdit,
      this.onTap,
      required this.formKey, this.title, this.description, this.id});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller =
        Get.find(tag: ControllerTagConstants.homeControllerTag);
    bool isValidTitle = false;
    bool isValidDescription = false;

    return StatefulBuilder(
      builder: (context, setState) {
        if(isEdit){
          titleController.text = title!;
          descriptionController.text = description!;
        }
        return Obx(() => Container(
          height: 500,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    StringConstants.addItem,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        controller.captureImageFromGallery();
                      },
                      child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                          child: controller.isLeadImgSelected.value
                              ? Image.file(controller.imageFile!)
                              : Image.asset(
                            AssetsConstants.mediaIcon2,
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: StringConstants.titleTxt,
                        hintText: StringConstants.titleHintTxt,
                        errorText:
                        isValidTitle ? "Please enter valid Title" : null,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: StringConstants.descriptionTxt,
                      hintText: StringConstants.descriptionHintTxt,
                      border: OutlineInputBorder(),
                      errorText: isValidDescription
                          ? "Please enter valid Title"
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      log("onTap");
                      setState(() {
                        if (titleController.text.isEmpty) {
                          isValidTitle = true;
                        } else if (descriptionController.text.isEmpty) {
                          isValidDescription = true;
                        } else {
                          log("Valid");
                          if(isEdit){
                            controller.updateItem(id);
                          }else{
                            controller.createItem();
                          }

                        }
                      });
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.primary1,
                          border: Border.all(color: AppColors.primary1),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          StringConstants.saveTxt,
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
