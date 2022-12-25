import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading:const Icon(Icons.person_add_alt_1_outlined),
        actions: const[
          Icon(Icons.more_horiz),
        ],
        title: Text("username",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: " ",
                      width: 100,
                      height: 100,
                      placeholder: (context,url)=> const CircularProgressIndicator(),
                      errorWidget: (context,url,error)=>const Icon(Icons.error),
                    ),
                  )
                ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
