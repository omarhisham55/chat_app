import 'dart:async';

import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/images.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const SplashScreen({super.key, required this.sharedPreferences});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  User? user;
  _goNext(User? user) {
    if (user == null && !widget.sharedPreferences.containsKey("userId")) {
      Navigator.pushReplacementNamed(context, Routes.welcomeRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.navigationRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () => _goNext(user));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenCubit, SplashScreenState>(
      listener: (context, state) {
        if (state is GetSavedUserSuccessState) {
          user = state.userModel;
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }
}
