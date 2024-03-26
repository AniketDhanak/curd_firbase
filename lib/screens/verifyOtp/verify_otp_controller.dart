import 'dart:developer';

import 'package:curd/constants/database_keys.dart';
import 'package:curd/constants/route_constants.dart';
import 'package:curd/firebaseService/firebase_auth_service.dart';
import 'package:curd/sharedPrefs/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {

  FirebaseAuthService authService = FirebaseAuthService();
  var isValid = false.obs;
  var isLoading = false.obs;
  var verificationId = "".obs;
  var myOtp = "".obs;

  @override
  onInit() {
    SharedPrefs.init();
    var arg = Get.arguments;
    log("arg: $arg");
    verificationId.value = arg['verificationId'];

    authService.initializeApp();
    super.onInit();
  }

  validateOtp(otp) {
    log("valid: $otp");
    verifyOtp(otp);
  }

  verifyOtp(String otp)  async{
    try {
      isLoading.value= true;
      log("otp: $otp");
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp);
      signInWithCredential(authCredential);
    } catch (e) {
      isLoading.value= false;
      log("Error: $e");
    }
  }

  void signInWithCredential(PhoneAuthCredential authCredential) async{
    log("authCredential: ${authCredential.smsCode}");
    try{
    await  FirebaseAuth.instance.signInWithCredential(authCredential);
  await SharedPrefs.setBool(DatabaseKeys.isLogin, true);
    isLoading.value= false;
  Get.offAllNamed(RouteConstants.homeScreen);
    }catch(e){
      log("Error signing: $e");
      isLoading.value= false;
    }
    // FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
    //   //Navigate to home
    //   Get.offAllNamed(RouteConstants.homeScreen);
    // }).onError((error, stackTrace) {
    //   log("singingError: ${error}");
    // });
  }
}
