import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/models/users.dart';
import 'package:tiktok_clone_app/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone_app/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;


  @override
  void onReady() {
   _user=Rx<User?>(firebaseAuth.currentUser);
   _user.bindStream(firebaseAuth.authStateChanges());
   ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User?user){
    if(user==null){
      Get.offAll(()=>LoginScreen());
    }else{
      Get.offAll(()=>const HomeScreen());
    }
  }


   File? get profilePic=>_pickedImage.value;
   User get user=> _user.value!;

  /// Pic Image
  void picImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      Get.snackbar("Profile pic",
          "You have successfully selected your profile picture!");
    }
    _pickedImage = Rx<File?>(File(pickImage!.path));
  }

  ///image upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child(
          "profilePics",
        )
        .child(
          firebaseAuth.currentUser!.uid,
        );

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Create user
  void register(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        /// save data
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);

        Users users = Users(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );

        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(users.toJson());
      } else {
        Get.snackbar("Error Creating Account", "Please Enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", e.toString());
    }
  }


  void loginUser(String email,String password)async{

    try{
      if(email.isNotEmpty &&
          password.isNotEmpty){
            /// login successfully
              await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
              print("log Successfully");
      }else{
        Get.snackbar("Error Login", "Please Enter all the fields");
      }
    }catch(e){
      Get.snackbar("Error Login", e.toString());
    }
  }
}
