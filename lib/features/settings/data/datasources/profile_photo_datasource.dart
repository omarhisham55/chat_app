import 'dart:io';

import 'package:chat_app/core/firebase/firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfilePhotoDatasource {
  Future<UploadTask> addProfilePhoto({required File file});
}

class ProfilePhotoDatasourceImpl extends ProfilePhotoDatasource {
  final FirebaseStore firebaseStore;

  ProfilePhotoDatasourceImpl({required this.firebaseStore});
  @override
  Future<UploadTask> addProfilePhoto({required File file}) async {
    return await firebaseStore.storeProfileImage(file: file);
  }
}
