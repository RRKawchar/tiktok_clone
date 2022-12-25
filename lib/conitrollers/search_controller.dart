import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/models/users.dart';

class SearchController extends GetxController{

  final Rx<List<Users>> _searchUsered=Rx<List<Users>>([]);

  List<Users> get searchUsered=>_searchUsered.value;


  searchUser(String typeUser)async{
    _searchUsered.bindStream(
      fireStore.collection('users').where('name',isGreaterThanOrEqualTo: typeUser).snapshots().map((QuerySnapshot query){
      List<Users> retVal=[];
      for(var element in query.docs){
        retVal.add(Users.fromSnap(element));
      }
      return retVal;
      })
    );
  }
}