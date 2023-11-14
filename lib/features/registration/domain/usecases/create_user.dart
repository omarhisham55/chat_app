import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/registration/domain/repositories/create_user_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserByEmailUseCase implements UseCase<dynamic, List<String>> {
  final CreateUserRepository createUserRepository;

  CreateUserByEmailUseCase({required this.createUserRepository});

  @override
  Future<Either<Failure, dynamic>> call(List<String> params) =>
      createUserRepository.createUserByEmail(
        username: params[0],
        email: params[1],
        password: params[2],
      );
}

class CreateUserByPhoneNumberUseCase implements UseCase<void, String> {
  final CreateUserRepository createUserRepository;

  CreateUserByPhoneNumberUseCase({required this.createUserRepository});

  @override
  Future<Either<Failure, void>> call(String params) =>
      createUserRepository.createUserByPhoneNumber(phoneNumber: params);
}

class SendSmsUseCase implements UseCase<void, String> {
  final CreateUserRepository createUserRepository;

  SendSmsUseCase({required this.createUserRepository});

  @override
  Future<Either<Failure, void>> call(String params) =>
      createUserRepository.sendSmsCode(smsCode: params);
}
