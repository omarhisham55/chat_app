import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/core/widgets/dividers.dart';
import 'package:chat_app/core/widgets/indicator.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:chat_app/features/registration/presentation/widgets/sign_up_widgets/sign_up_form.dart';
import 'package:chat_app/features/registration/presentation/widgets/toggle_registration.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  _goToLoginAfterAccountCreated(_, state) {
    if (state is CreateUserSuccessState) {
      _goToLogin(_);
    }
  }

  _goToLogin(_) => Navigator.pushNamed(_, Routes.loginRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SignUpForm(),
              orDivider(),
              RoundedButton(
                text: "Sign Up with your number",
                buttonPadding: const EdgeInsets.only(top: 20),
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.signUpByPhoneRoute,
                ),
              ),
              ToggleRegistration(
                text: "Already have an account?",
                buttonText: "Login",
                onTap: () => _goToLogin(context),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! LoadingCreateUserState,
            fallback: (context) => const LoadingIndicator(),
            builder: (context) {
              return RoundedButton(
                text: "Confirm",
                buttonPadding: const EdgeInsets.all(10),
                onPressed: () => BlocProvider.of<SignUpCubit>(context)
                        .formKey
                        .currentState!
                        .validate()
                    ? BlocProvider.of<SignUpCubit>(context)
                        .createUserAccountByEmail()
                        .then((value) =>
                            _goToLoginAfterAccountCreated(context, state))
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
