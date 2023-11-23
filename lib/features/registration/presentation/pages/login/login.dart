import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/core/widgets/indicator.dart';
import 'package:chat_app/features/registration/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/registration/presentation/widgets/login_widgets/login_form.dart';
import 'package:chat_app/features/registration/presentation/widgets/toggle_registration.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          children: [
            Text(
              "Login",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const LoginForm(),
            ToggleRegistration(
              text: "Don't have an account?",
              buttonText: "SignUp",
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      bottomSheet: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GetUserSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.navigationRoute,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! LoadingGetUserState,
            fallback: (context) => const LoadingIndicator(),
            builder: (context) {
              return RoundedButton(
                text: "Confirm",
                buttonPadding: const EdgeInsets.all(10),
                onPressed: () => BlocProvider.of<LoginCubit>(context)
                        .formKey
                        .currentState!
                        .validate()
                    ? BlocProvider.of<LoginCubit>(context)
                        .userLogin(context)
                        .then(
                          (value) => BlocProvider.of<SplashScreenCubit>(context)
                              .getSavedUser(),
                        )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
