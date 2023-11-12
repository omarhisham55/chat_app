import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/registration/domain/repositories/get_user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements UseCase<User, List<String>> {
  final GetUserRepository getUserRepository;

  GetUserUsecase({required this.getUserRepository});

  @override
  Future<Either<Failure, User>> call(List<String> params) {
    return getUserRepository.getUser(email: params[0], password: params[1]);
  }
}

class GetSavedUserUsecase implements UseCase<User?, NoParams> {
  final GetUserRepository getUserRepository;

  GetSavedUserUsecase({required this.getUserRepository});
  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return getUserRepository.getCachedUser();
  }
}
