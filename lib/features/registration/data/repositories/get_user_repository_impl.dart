import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/registration/data/datasources/get_user_remote_datasource.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/registration/domain/repositories/get_user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserRepositoryImpl implements GetUserRepository {
  final NetworkInfo network;
  final GetUserDatasource getUserDatasource;

  GetUserRepositoryImpl({
    required this.network,
    required this.getUserDatasource,
  });

  @override
  Future<Either<Failure, User>> getUser({
    required String email,
    required String password,
  }) async {
    if (await network.isConnected) {
      try {
        final getUser = await getUserDatasource.getUser(
          email: email,
          password: password,
        );
        getUserDatasource.cachedUser(getUser.id);
        return Right(getUser);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getCachedUser() async {
    try {
      return Right(await getUserDatasource.getCachedUser());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
