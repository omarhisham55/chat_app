import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/chat_page/presentation/pages/into_chat.dart';
import 'package:chat_app/features/navigation_page/presentation/pages/navigation_page.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/registration/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/registration/presentation/pages/login/login.dart';
import 'package:chat_app/features/registration/presentation/pages/sign_up/otp_verification.dart';
import 'package:chat_app/features/registration/presentation/pages/sign_up/phone_sign_up.dart';
import 'package:chat_app/features/registration/presentation/pages/sign_up/sign_up.dart';
import 'package:chat_app/features/settings/presentation/pages/setting_details_pages/setting_details_page.dart';
import 'package:chat_app/features/settings/presentation/pages/settings.dart';
import 'package:chat_app/features/welcome_page/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/injection_container.dart' as di;

class Routes {
  static const String initialRoute = "/";
  static const String signUpRoute = "/signup";
  static const String signUpByPhoneRoute = "/phoneSignup";
  static const String otpVerificationRoute = "/otpVerificationRoute";
  static const String loginRoute = "/login";
  static const String navigationRoute = "/navigation";
  static const String settingsRoute = "/settings";
  static const String settingsDetailsRoute = "/settingsDetails";
  static const String intoChatRoute = "/intoChatDetails";

  Routes._();
  factory Routes() => Routes._();

  Map<String, Route<dynamic> Function(RouteSettings settings)> get routes {
    return {
      initialRoute: (settings) => MaterialPageRoute(
            builder: (context) => const WelcomePage(),
            settings: settings,
          ),
      signUpRoute: (settings) => MaterialPageRoute(
            builder: (context) => const SignUpPage(),
            settings: settings,
          ),
      signUpByPhoneRoute: (settings) => MaterialPageRoute(
            builder: (context) => const PhoneSignUp(),
            settings: settings,
          ),
      otpVerificationRoute: (settings) => MaterialPageRoute(
            builder: (context) => const OTPVerification(),
            settings: settings,
          ),
      loginRoute: (settings) => MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => di.injection<LoginCubit>(),
              child: const Login(),
            ),
            settings: settings,
          ),
      navigationRoute: (settings) => MaterialPageRoute(
            builder: (context) => const NavigationPage(),
            settings: settings,
          ),
      settingsRoute: (settings) => MaterialPageRoute(
            builder: (context) => Settings(),
            settings: settings,
          ),
      settingsDetailsRoute: (settings) => MaterialPageRoute(
            builder: (context) => SettingDetailPage(
              title: settings.arguments as String,
            ),
            settings: settings,
          ),
      intoChatRoute: (settings) => MaterialPageRoute(
            builder: (context) => IntoChat(
              otherUser: settings.arguments as User,
            ),
            settings: settings,
          ),
    };
  }

  Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            AppStrings.undefinedRoute,
            style: Theme.of(_).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}

class GenerateRoute {
  static Route onGeneratedRoute(RouteSettings settings) {
    final routeBuilder = Routes().routes[settings.name];
    if (routeBuilder == null) {
      return Routes().undefinedRoute();
    }
    return routeBuilder(settings);
  }
}
