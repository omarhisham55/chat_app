import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/features/chat_page/chat_injection.dart';
import 'package:chat_app/features/registration/registration_injection.dart';
import 'package:chat_app/features/settings/settings_injection.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:chat_app/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injection = GetIt.instance;

Future<void> init() async {
  //core
  injection.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoManager(
      connectionChecker: injection(),
    ),
  );
  injection.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  injection.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  injection.registerLazySingleton<FirebaseAuthConsumer>(
    () => FirebaseAuthConsumer(
      client: injection(),
      firebsaeData: injection(),
    ),
  );
  injection.registerLazySingleton<FirebaseConsumer>(
    () => FirebaseConsumer(
      firebaseFirestore: injection(),
    ),
  );

  //external
  final firebaseInit = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => firebaseInit);
  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerLazySingleton(() => InternetConnectionChecker());

  //features
  injection.registerFactory(
    () => SplashScreenCubit(
      getSavedUserUsecase: injection(),
      getAllUsersUsecase: injection(),
    ),
  );
  injection.registerFactory(
    () => SplashScreen(sharedPreferences: sharedPreferences),
  );
  registrationInjection();
  settingsInjection();
  chatInjection();
}
