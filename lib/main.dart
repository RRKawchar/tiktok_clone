import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/conitrollers/auth_controller.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone_app/views/screens/auth/signup_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    print("Auth Controller");
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      home: LoginScreen(),
    );
  }
}


