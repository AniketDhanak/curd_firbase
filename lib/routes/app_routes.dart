
import 'package:curd/constants/route_constants.dart';
import 'package:curd/screens/home/home_screen.dart';
import 'package:curd/screens/login/login_screen.dart';
import 'package:curd/screens/splash/splash.dart';
import 'package:curd/screens/verifyOtp/verify_otp_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final routes = [
    GetPage(
        name: RouteConstants.initialRoute, page: () => const SplashScreen()),
    GetPage(
        name: RouteConstants.loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: RouteConstants.verifyOtpScreen, page: () => const VerifyOtpScreen()),
    GetPage(
        name: RouteConstants.homeScreen, page: () => const HomeScreen()),

  ];
}