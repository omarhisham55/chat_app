import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/images.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  _goToSignUp(_) => Navigator.pushReplacementNamed(_, Routes.signUpRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyContent(context),
      bottomSheet: RoundedButton(
        text: "Get Started",
        textPadding: const EdgeInsets.symmetric(vertical: 15),
        buttonPadding: const EdgeInsets.all(10),
        onPressed: () => _goToSignUp(context),
      ),
    );
  }

  Widget _bodyContent(_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo),
            const SizedBox(height: 20),
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
