import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _users = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _users.value;
  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideo = await fireStore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myVideo.docs.length; i++) {
      thumbnails.add((myVideo.docs[i].data() as dynamic)['thumbnail']);
    }
    DocumentSnapshot userDoc =
        await fireStore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideo.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followersDoc = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followersDoc.docs.length;
    following = followingDoc.docs.length;

    fireStore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });
    _users.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails
    };
    update();
  }

  followUser() async {
    var doc = await fireStore
        .collection('users')
        .doc(_uid.value)
        .collection("followers")
        .doc(authController.user.uid)
        .get();
    if (!doc.exists) {
      await fireStore
          .collection('users')
          .doc(_uid.value)
          .collection("followers")
          .doc(authController.user.uid)
          .set({});
      await fireStore
          .collection('users')
          .doc(authController.user.uid)
          .collection("following")
          .doc(_uid.value)
          .set({});

      _users.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    }else{
      await fireStore
          .collection('users')
          .doc(_uid.value)
          .collection("followers")
          .doc(authController.user.uid)
          .delete();
      await fireStore
          .collection('users')
          .doc(authController.user.uid)
          .collection("following")
          .doc(_uid.value)
          .delete();

      _users.value.update(
        'followers',
            (value) => (int.parse(value) -1).toString(),
      );
    }
    _users.value.update('isFollowing', (value) => !value);
    update();
  }
}
