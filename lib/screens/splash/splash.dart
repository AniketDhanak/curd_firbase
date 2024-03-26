import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/screens/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller =
        Get.find(tag: ControllerTagConstants.splashControllerTag);

    return const Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
