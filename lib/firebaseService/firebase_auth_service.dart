import 'dart:developer';

import 'package:curd/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService{


  late final FirebaseApp app;
  late final FirebaseAuth auth;


  initializeApp()async{
    auth = FirebaseAuth.instance;
    // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

}