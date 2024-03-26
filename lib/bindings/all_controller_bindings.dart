import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/screens/home/home_controller.dart';
import 'package:curd/screens/login/login_controller.dart';
import 'package:curd/screens/splash/splash_controller.dart';
import 'package:curd/screens/verifyOtp/verify_otp_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(),
        tag: ControllerTagConstants.splashControllerTag, fenix: true);

    Get.lazyPut<LoginController>(() => LoginController(),
        tag: ControllerTagConstants.loginScreenControllerTag, fenix: true);

    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController(),
        tag: ControllerTagConstants.verifyOtpScreenControllerTag, fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),
        tag: ControllerTagConstants.homeControllerTag, fenix: true);
  }

}