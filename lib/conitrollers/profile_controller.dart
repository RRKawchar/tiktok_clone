import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/constants.dart';

class ProfileController extends GetxController{


  final Rx<Map<String,dynamic>> _users=Rx<Map<String,dynamic>>({});
  Map<String,dynamic> get user=> _users.value;
  final Rx<String>_uid="".obs;


  updateUserId(String uid){
  _uid.value=uid;
  getUserData();

  }

  getUserData()async{

    List<String> thumbnails=[];
    QuerySnapshot myVideo= await fireStore.collection('videos').where('uid',isEqualTo: _uid.value).get();
    for(int i=0;i<myVideo.docs.length;i++){

    }
  }
}