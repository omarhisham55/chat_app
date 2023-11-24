import 'dart:io';

import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/settings/domain/repositories/profile_photo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePhotoUsecase implements UseCase<UploadTask, File> {
  final ProfilePhotoRepository profilePhotoRepository;

  ProfilePhotoUsecase({required this.profilePhotoRepository});
  @override
  Future<Either<Failure, UploadTask>> call(File file) async {
    return await profilePhotoRepository.addProfilePhoto(file: file);
  }
}
