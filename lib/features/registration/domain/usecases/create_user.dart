import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/registration/domain/repositories/create_user_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUser implements UseCase<dynamic, List<String>> {
  final CreateUserRepository createUserRepository;

  CreateUser({required this.createUserRepository});

  @override
  Future<Either<Failure, dynamic>> call(List<String> params) =>
      createUserRepository.createUser(
        username: params[0],
        email: params[1],
        password: params[2],
      );
}
