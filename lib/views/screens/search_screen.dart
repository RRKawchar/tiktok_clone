import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/conitrollers/search_controller.dart';
import 'package:tiktok_clone_app/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController=Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration:const InputDecoration(
              filled: false,
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 18,color: Colors.white)
          ),
          onFieldSubmitted: (value)=>searchController.searchUser(value),
        ),
      ),
      body:searchController.searchUsered.isEmpty? const Center(
        child: Text("Search for users!",style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ):ListView.builder(
          itemCount: searchController.searchUsered.length,
          itemBuilder: (context,index){
            final user=searchController.searchUsered[index];
            return InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      user.profilePhoto
                  ),
                ),
                title: Text(
                  user.name,style:const TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            );
          }),
    ));
  }
}
