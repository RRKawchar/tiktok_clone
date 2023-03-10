import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/conitrollers/auth_controller.dart';
import 'package:tiktok_clone_app/views/screens/add_video_screen.dart';
import 'package:tiktok_clone_app/views/screens/profile_screen.dart';
import 'package:tiktok_clone_app/views/screens/search_screen.dart';
import 'package:tiktok_clone_app/views/screens/video_screen.dart';

/// PAGE
var pages=[
 VideoScreen(),
 SearchScreen(),
 const AddVideoScreen(),
 Center(child: Text("Message Screen")),
 ProfileScreen(uid: authController.user.uid)
];


/// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

///FIREBASE
 var firebaseAuth=FirebaseAuth.instance;
 var firebaseStorage=FirebaseStorage.instance;
 var fireStore=FirebaseFirestore.instance;


 ///CONTROLLERS
  var authController=AuthController.instance;

/// I am Riyazur Rohman Kawchar