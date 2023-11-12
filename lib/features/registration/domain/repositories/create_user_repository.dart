import 'package:chat_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CreateUserRepository {
  Future<Either<Failure, dynamic>> createUser({
    required String username,
    required String email,
    required String password,
  });
}