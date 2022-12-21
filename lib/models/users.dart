import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users {
  String name;
  String profilePhoto;
  String email;
  String uid;

  Users({
    required this.name,
    required this.profilePhoto,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() =>
      {"name": name, "profilePhoto": profilePhoto, "email": email, "uid": uid};

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
        name: snapshot['name'],
        profilePhoto: snapshot['profilePhoto'],
        email: snapshot['email'],
        uid: snapshot['uid']);
  }
}
