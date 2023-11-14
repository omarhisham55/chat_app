import 'package:chat_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CreateUserRepository {
  Future<Either<Failure, dynamic>> createUserByEmail({
    required String username,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> createUserByPhoneNumber({
    required String phoneNumber,
  });
  Future<Either<Failure, dynamic>> sendSmsCode({required String smsCode});
}
