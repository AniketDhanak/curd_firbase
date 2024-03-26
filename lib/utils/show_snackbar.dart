
import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  successSnackBar(String message) {
    Get.snackbar(
      StringConstants.success,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.darkGreen,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  errorSnackBar(String message) {
    Get.snackbar(
      StringConstants.failure,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary1,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  validationSnackBar(String message) {
    Get.snackbar(
      StringConstants.somethingWentWrong,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary1,
      borderRadius: 20,
      messageText: Text(message,style: TextStyle(fontSize: 12, color: Colors.black),),
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
    );
  }


}