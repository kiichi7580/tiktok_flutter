import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/auth_controller.dart';
import 'package:tiktok_flutter/models/comment.dart';

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
      firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
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
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
          username: (userDoc.data() as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          uid: authController.user.uid,
          id: 'comment $len',
          profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
        );
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $len')
            .set(
              comment.toJson(),
            );
        DocumentSnapshot snap =
            await firestore.collection('videos').doc(_postId).get();
        await firestore.collection('videos').doc(_postId).update({
          'commentCount': (snap.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (err) {
      Get.snackbar(
        'Error While Commenting',
        err.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
