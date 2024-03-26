import 'dart:developer';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd/model/item_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  final String? uid;

  FireStoreService({this.uid});


  //reference to leads
  final CollectionReference referenceToProducts = FirebaseFirestore.instance.collection("products");

  //storage reference
  final FirebaseStorage storage = FirebaseStorage.instance;

  //create new leads
  Future createItems(ItemModel model, File? imgFile)async{
    DateTime currentDate = DateTime.now();
    var imgPath;
    //check if image is selected or not
    if(imgFile != null){
      Reference ref = storage.ref().child("item_" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imgFile);
      uploadTask.then((res) async{
        imgPath = await res.ref.getDownloadURL();
        log("imgPath: ${imgPath}");
        referenceToProducts.doc().set(
            {
              "title": model.title,
              "description": model.description,
              "image": imgPath,
              "createdAt": currentDate,
            }
        ).onError((error, stackTrace){
          log("setData: $error");
          return error;
        });
      }).onError((error, stackTrace) {
        log("imgPath: $error");
        return;
      });
    }else{
      return referenceToProducts.doc().set(
          {
            "title": model.title,
            "description": model.description,
            "image": imgPath,
            "createdAt": currentDate,
          }
      ).onError((error, stackTrace){
        log("setData: $error");
        return error;
      });
    }

  }

  Future updateItems(ItemModel model, File? imgFile, id)async{
    DateTime currentDate = DateTime.now();
    var imgPath;
    //check if image is selected or not
    if(imgFile != null){
      Reference ref = storage.ref().child("item_" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imgFile);
      uploadTask.then((res) async{
        imgPath = await res.ref.getDownloadURL();
        log("docIt: ${id}");
        referenceToProducts.doc(id).update(
            {
              "title": model.title,
              "image": imgPath,
              "description": model.description,
            }
        ).onError((error, stackTrace){
          log("setData: $error");
          return error;
        });
      }).onError((error, stackTrace) {
        log("imgPath: $error");
        return;
      });
    }else{
      return referenceToProducts.doc(id).update(
          {
            "title": model.title,
            "image": imgPath,
            "description": model.description,
          }
      ).onError((error, stackTrace){
        log("setData: $error");
        return error;
      });
    }

  }

  Future deleteData(String id) async {
    try {
      await referenceToProducts
          .doc(id)
          .delete();
    } catch (e) {
      return false;
    }
  }
}