import 'package:chat_app/features/settings/data/datasources/profile_photo_datasource.dart';
import 'package:chat_app/features/settings/data/repositories/profile_photo_repository_impl.dart';
import 'package:chat_app/features/settings/domain/repositories/profile_photo_repository.dart';
import 'package:chat_app/features/settings/domain/usecases/profile_photo_usecase.dart';
import 'package:chat_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/features/settings/presentation/widgets/setting_details_page_body_widgets/account.dart';
import 'package:chat_app/injection_container.dart';

Future<void> settingsInjection() async {
  injection.registerFactory(
    () => SettingsCubit(profilePhotoUsecase: injection()),
  );

  injection.registerLazySingleton<ProfilePhotoRepository>(
    () => ProfilePhotoRepositoryImpl(
        network: injection(), profilePhotoDatasource: injection()),
  );

  injection.registerLazySingleton<ProfilePhotoDatasource>(
    () => ProfilePhotoDatasourceImpl(firebaseStore: injection()),
  );

  injection.registerLazySingleton(
    () => ProfilePhotoUsecase(profilePhotoRepository: injection()),
  );

  injection.registerLazySingleton(
    () => AccountBodyContent(sharedPreferences: injection()),
  );
}
