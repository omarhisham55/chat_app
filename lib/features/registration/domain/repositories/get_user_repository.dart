import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class GetUserRepository {
  Future<Either<Failure, User>> getUser({
    required String email,
    required String password,
  });
  Future<Either<Failure, User?>> getCachedUser();
}

abstract class GetAllUsersReopsitory {
  Future<Either<Failure, List<User>>> getAllUsers();
}
