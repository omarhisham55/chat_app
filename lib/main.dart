import 'package:chat_app/bloc_observer.dart';
import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/config/theme/themes.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.injection<SignUpCubit>()),
        BlocProvider(
          create: (context) => di.injection<WelcomePageCubit>()..getSavedUser()..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => GenerateRoute.onGeneratedRoute(settings),
      ),
    );
  }
}
