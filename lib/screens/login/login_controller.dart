import 'dart:developer';

import 'package:curd/constants/route_constants.dart';
import 'package:curd/firebaseService/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  TextEditingController mobileNumController = TextEditingController();

  var mobileNumNotValid = false.obs;
  var isLoading = false.obs;

  onTapContinue(){
    log("onTapContinue");
    if(mobileNumController.text.isEmpty || mobileNumController.text.length != 10){
      // show message
      mobileNumNotValid.value = true;
    }else{
      // naviagte to next
      log("else");
      verifyNumber(mobileNumController.text);
      // var args = {
      //   "verificationId": "Aniket"
      // };
      // Get.toNamed(RouteConstants.verifyOtpScreen, arguments: args);
    }
  }

  FirebaseAuthService authService = FirebaseAuthService();

  @override
  void onInit() {
    authService.initializeApp();
    super.onInit();
  }


  verifyNumber(String phoneNumber)async{
    isLoading.value =true;
    await authService.auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {
        log("verificaitonCompleted: $credential");
        isLoading.value =false;
      },
      verificationFailed: (FirebaseAuthException e) {
        log("verificationFailed: ${e.message}");
        isLoading.value =false;
      },
      codeSent: (String verificationId, int? resendToken) {
        var args = {
          "verificationId" : verificationId
        };
        Get.toNamed(RouteConstants.verifyOtpScreen, arguments: args);
        log("codeSent: $verificationId");
        isLoading.value =false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("codeAutoRetrievalTimeout: $verificationId");
        isLoading.value =false;
      },
    );
  }
}