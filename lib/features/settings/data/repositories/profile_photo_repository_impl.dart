import 'dart:io';

import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/settings/data/datasources/profile_photo_datasource.dart';
import 'package:chat_app/features/settings/domain/repositories/profile_photo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePhotoRepositoryImpl implements ProfilePhotoRepository {
  final NetworkInfo network;
  final ProfilePhotoDatasource profilePhotoDatasource;

  ProfilePhotoRepositoryImpl(
      {required this.network, required this.profilePhotoDatasource});
  @override
  Future<Either<Failure, UploadTask>> addProfilePhoto(
      {required File file}) async {
    if (await network.isConnected) {
      try {
        return Right(await profilePhotoDatasource.addProfilePhoto(file: file));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
