import 'package:chat_app/features/registration/data/datasources/create_user_remote_datasource.dart';
import 'package:chat_app/features/registration/data/datasources/get_user_remote_datasource.dart';
import 'package:chat_app/features/registration/data/repositories/create_user_repository_impl.dart';
import 'package:chat_app/features/registration/data/repositories/get_user_repository_impl.dart';
import 'package:chat_app/features/registration/domain/repositories/create_user_repository.dart';
import 'package:chat_app/features/registration/domain/repositories/get_user_repository.dart';
import 'package:chat_app/features/registration/domain/usecases/create_user.dart';
import 'package:chat_app/features/registration/domain/usecases/get_user.dart';
import 'package:chat_app/features/registration/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:chat_app/injection_container.dart';

Future<void> registrationInjection() async {
  //bloc
  injection.registerFactory(
    () => SignUpCubit(createUser: injection()),
  );
  injection.registerFactory(
    () => LoginCubit(getUserUsecase: injection()),
  );
  //usecases
  injection.registerLazySingleton(
    () => CreateUser(createUserRepository: injection()),
  );
  injection.registerLazySingleton(
    () => GetUserUsecase(getUserRepository: injection()),
  );
  injection.registerLazySingleton(
    () => GetSavedUserUsecase(getUserRepository: injection()),
  );
  //repository
  injection.registerLazySingleton<CreateUserRepository>(
    () => CreateUserRepositoryImpl(
      network: injection(),
      createUserRemoteDataSource: injection(),
    ),
  );
  injection.registerLazySingleton<GetUserRepository>(
    () => GetUserRepositoryImpl(
      network: injection(),
      getUserDatasource: injection(),
    ),
  );
  //datasource
  injection.registerLazySingleton<CreateUserRemoteDataSource>(
    () => CreateUserRemoteDataSourceImpl(firebaseConsumer: injection()),
  );
  injection.registerLazySingleton<GetUserDatasource>(
    () => GetUserDatasourceImpl(
      firebaseConsumer: injection(),
      sharedPreferences: injection(),
    ),
  );
}
