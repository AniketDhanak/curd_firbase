import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/bindings/all_controller_bindings.dart';
import 'package:curd/constants/app_colors.dart';
import 'package:curd/constants/route_constants.dart';
import 'package:curd/constants/string_constants.dart';
import 'package:curd/extensions/color_extension.dart';
import 'package:curd/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'sharedPrefs/shared_prefs.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (kDebugMode) {
  //   try {
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return GetMaterialApp(
          title: StringConstants.title,
          theme: ThemeData(
            primarySwatch: AppColors.primary1.toMaterialColor(),
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: AllControllerBinding(),
          initialRoute: RouteConstants.initialRoute,
          getPages: AppRoutes.routes,
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.1 );
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: scale),
                child: child!);
          },
        );
      });
    });
  }
}


