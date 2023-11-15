import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:chat_app/features/registration/presentation/widgets/sign_up_widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneSignUp extends StatelessWidget {
  const PhoneSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your phone number",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Expanded(
              child: PhoneSignUpForm(),
            ),
            RoundedButton(
              text: "Continue",
              onPressed: () => BlocProvider.of<SignUpCubit>(context)
                      .phoneFormKey
                      .currentState!
                      .validate()
                  ? BlocProvider.of<SignUpCubit>(context)
                      .createUserAccountByPhoneNumber()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
