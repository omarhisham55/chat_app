import 'dart:io';

import 'package:chat_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfilePhotoRepository {
  Future<Either<Failure, UploadTask>> addProfilePhoto({required File file});
}
