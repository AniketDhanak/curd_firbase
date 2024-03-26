import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/screens/loader/loader.dart';
import 'package:curd/screens/verifyOtp/verify_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VerifyOtpController controller =
        Get.find(tag: ControllerTagConstants.verifyOtpScreenControllerTag);

    return Obx(() => Loader(
        isCallInProgress: controller.isLoading.value,
        child: mainUI(context, controller)));
  }

  Widget mainUI(BuildContext context, VerifyOtpController controller) {
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
                StringConstants.verifyYourPhoneTxt,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                StringConstants.enterCodeTxt,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary1,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 10,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: AppColors.primary1,
                enabledBorderColor: AppColors.borderColorTxtField,
                showFieldAsBox: true,
                fieldWidth: 45,
                onCodeChanged: (value){
                  if(value.length == 10){
                    controller.myOtp.value = value;
                    controller.validateOtp(value);
                  }
                },
                onSubmit: (String verificationCode) {
                  controller.validateOtp(verificationCode);
                }, // end onSubmit
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.validateOtp(controller.myOtp.value);
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
                        StringConstants.verifyTxt,
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
