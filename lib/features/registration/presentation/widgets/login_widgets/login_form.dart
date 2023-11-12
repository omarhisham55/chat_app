import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/registration/presentation/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/injection_container.dart' as di;

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit get = di.injection<LoginCubit>().get(context);
        return Form(
          key: get.formKey,
          child: Column(
            children: [
              ChatTextFormField(
                label: "Email",
                controller: get.emailController,
                validator: (value) {
                  if (!value!.contains("@") || !value.contains(".com")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              ChatTextFormField(
                label: "Password",
                controller: get.passwordController,
                obscure: get.obscure,
                suffix: IconButton(
                  onPressed: () => get.changeObscure(),
                  icon: Icon(
                    get.obscure
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter valid password";
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
