import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/constants.dart';

class AuthController extends GetxController {
  ///upload to firebase storage
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
    TaskSnapshot snap=await uploadTask;

    String downloadUrl= await snap.ref.getDownloadURL();
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
       String downloadUrl= await _uploadToStorage(image);
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", e.toString());
    }
  }
}
