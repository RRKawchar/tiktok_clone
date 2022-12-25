import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = '';
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      fireStore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retVal = [];
          for (var element in query.docs) {
            retVal.add(Comment.fromSnap(element));
          }
          return retVal;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await fireStore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: 'comment $len',
        );
        await fireStore
            .collection("videos")
            .doc(_postId)
            .collection('comments')
            .doc('comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await fireStore.collection('videos').doc(_postId).get();
        await fireStore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error while commenting', e.toString());
    }
  }
}
