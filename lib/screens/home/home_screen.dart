import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/assets_constants.dart';
import 'package:curd/constants/controller_tag_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/screens/home/home_controller.dart';
import 'package:curd/screens/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller =
        Get.find(tag: ControllerTagConstants.homeControllerTag);

    return Obx(() => Loader(
        isCallInProgress: controller.isLoading.value,
        child: mainUI(context, controller)));
  }

  Widget mainUI(BuildContext context, HomeScreenController controller) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 64,
            decoration: BoxDecoration(
                color: AppColors.primary1.withOpacity(0.3),
                border: const Border(
                    bottom: BorderSide(color: AppColors.borderColorTxtField))),
            child: const Center(
              child: Text(
                StringConstants.itemTxt,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
                stream: controller.usersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView(
                      children: documents
                          .map((e) => itemCard(e['title'], e['description'],
                              e['image'] ?? "", controller, e))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(StringConstants.somethingWentWrong);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ],
      )),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FloatingActionButton.large(
          onPressed: () {
            controller.onTapAddItem(false, "", "", "");
          },
          backgroundColor: AppColors.addButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemCard(String title, String description, String imagePath,
      HomeScreenController controller, DocumentSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: GestureDetector(
        onTap: () {
          controller.onTapAddItem(true, title, description, snapshot.id);
        },
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  controller.deleteItem(snapshot.id);
                },
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: AppColors.itemCardBg,
            elevation: 4,
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                      image: imagePath == "" ?  const DecorationImage(
                        image:  AssetImage(AssetsConstants.mediaIcon),
                        fit: BoxFit.fill,
                      ): DecorationImage(
                        image:  NetworkImage(imagePath),
                        fit: BoxFit.fill,
                      ),
                      // color: AppColors.borderColorTxtField,
                      borderRadius: BorderRadius.circular(12)),
                  // child: imagePath != ""
                  //     ? Image.network(imagePath, fit: BoxFit.fill)
                  //     : Image.asset(AssetsConstants.mediaIcon,
                  //         fit: BoxFit.fill),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary1.withOpacity(0.3),
                    child: const Icon(Icons.mode_edit_outline_outlined),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

/*Widget itemCard(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: AppColors.itemCardBg,
        elevation: 4,
        child: Row(
         children: [
           Container(
             height: 100,
             decoration: BoxDecoration(
               // color: AppColors.borderColorTxtField
               borderRadius: BorderRadius.circular(12)
             ),
             child: Image.asset(AssetsConstants.mediaIcon, fit: BoxFit.fill),
           )
         ],
        ),
      ),
    );
  }*/
}
