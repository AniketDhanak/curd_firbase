
import 'dart:developer';

import 'package:curd/constants/database_keys.dart';
import 'package:curd/constants/route_constants.dart';
import 'package:curd/sharedPrefs/shared_prefs.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    startTimer();
    SharedPrefs.init();
    super.onInit();
  }

  startTimer() async {
    bool isLogin = SharedPrefs.getBool(DatabaseKeys.isLogin);
    log("isLogin: $isLogin");
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      isLogin
          ? Get.offAllNamed(RouteConstants.homeScreen)
          : Get.offAllNamed(RouteConstants.loginScreen);
    });
  }
}
