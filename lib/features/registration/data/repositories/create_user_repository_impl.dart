import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/registration/data/datasources/create_user_remote_datasource.dart';
import 'package:chat_app/features/registration/domain/repositories/create_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUserRepositoryImpl implements CreateUserRepository {
  final NetworkInfo network;
  final CreateUserRemoteDataSource createUserRemoteDataSource;

  CreateUserRepositoryImpl({
    required this.network,
    required this.createUserRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserCredential>> createUserByEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    if (await network.isConnected) {
      try {
        final createUser = await createUserRemoteDataSource.createUserByEmail(
          username: username,
          email: email,
          password: password,
        );
        return Right(createUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createUserByPhoneNumber(
      {required String phoneNumber}) async {
    if (await network.isConnected) {
      try {
        final createUser = await createUserRemoteDataSource
            .createUserByPhoneNumber(phoneNumber: phoneNumber);
        return createUser ? Right(createUser) : Left(ServerFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> sendSmsCode(
      {required String smsCode}) async {
    if (await network.isConnected) {
      try {
        final sendCode =
            await createUserRemoteDataSource.sendSmsCode(smsCode: smsCode);
        return Right(sendCode);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
