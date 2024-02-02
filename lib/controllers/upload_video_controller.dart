import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  // ビデオを圧縮する処理
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  // ビデオをfirestorageに追加する処理
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // 動画のサムネイルを取得する処理
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // 画像をfirestorageに追加する処理
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // ビデオをアップロードする処理を作成
  uploadVideo(
      String songname, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('video $len', videoPath);
      String thumbnail = await _uploadImageToStorage('video $len', videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: 'video $len',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songname: songname,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firestore.collection('videos').doc('video $len').set(
            video.toJson(),
          );
      print('set firestore video');
      Get.back();
      print('get.back');
    } catch (err) {
      Get.snackbar(
        'Error Uploading Video',
        err.toString(),
      );
    }
  }
}
