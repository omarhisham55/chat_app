import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/features/navigation_page/presentation/pages/navigation_page.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  _goToSignUp(_) => Navigator.pushReplacementNamed(_, Routes.signUpRoute);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
    return BlocConsumer<WelcomePageCubit, WelcomePageState>(
      listener: (context, state) {
        if (state is GetSavedUserSuccessState) {
          if (state.userModel is User) {
            isLoggedIn = true;
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetSavedUserState,
          builder: (context) {
            if (!isLoggedIn) {
              return Scaffold(
                body: _bodyContent(context),
                bottomSheet: RoundedButton(
                  text: "Get Started",
                  textPadding: const EdgeInsets.symmetric(vertical: 15),
                  buttonPadding: const EdgeInsets.all(10),
                  onPressed: () => _goToSignUp(context),
                ),
              );
            } else {
              return const NavigationPage();
            }
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _bodyContent(_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Chat",
              style: Theme.of(_).textTheme.displayMedium,
            ),
            Text(
              "Enjoy the first chat app",
              style: Theme.of(_).textTheme.headlineMedium,
            ),
          ],
        ),
      );
}
