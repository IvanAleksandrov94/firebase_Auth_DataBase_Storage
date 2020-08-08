import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore/models/cloud_storage_resoult.dart';
import 'package:flutter/material.dart';

class CloudStorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<CloudStorageResoult> getImageUrl() async {
    Future<StorageReference> a = storage.getReferenceFromUrl(
        "gs://firestore-dev-57a00.appspot.com/one/icons8-уолтер-уайт-100.png");

    var url = await a.then((doc) => doc.getDownloadURL());
    if (url.isNotEmpty) {
      return CloudStorageResoult(
        imageUrl: url,
      );
    }
    return null;
  }

  Future<CloudStorageResoult> uploadImage(
      {@required File imageToUpload, @required String title}) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResoult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }
    return null;
  }
}
