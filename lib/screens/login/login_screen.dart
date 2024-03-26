import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/assets_constants.dart';
import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/screens/loader/loader.dart';
import 'package:curd/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller =
        Get.find(tag: ControllerTagConstants.loginScreenControllerTag);

    return Obx(() => Loader(
        isCallInProgress: controller.isLoading.value,
        child: mainUI(context, controller)));
  }

  Widget mainUI(BuildContext context, LoginController controller) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                StringConstants.continueWithPhoneTxt,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: controller.mobileNumController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                onChanged: (value){
                  if(value.length == 10){
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                decoration: InputDecoration(
                  counterText: '',
                    labelText: StringConstants.mobileNumLabel,
                    errorText: controller.mobileNumNotValid.value
                        ? StringConstants.invalidMobileMsg
                        : null,
                    prefixIcon: Image.asset(AssetsConstants.callIcon),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.borderColorTxtField, width: 1),
                    )),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.onTapContinue();
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                        color: AppColors.primary1,
                        border: Border.all(color: AppColors.primary1),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        StringConstants.continueTxt,
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
