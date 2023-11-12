import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/injection_container.dart' as di;

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      SignUpCubit controller = di.injection<SignUpCubit>().get(context);
      return Form(
        key: controller.formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ChatTextFormField(
                label: "Username",
                controller: controller.usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter username";
                  }
                  return null;
                },
              ),
              ChatTextFormField(
                label: "Email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!value!.contains("@") || !value.contains(".com")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              ChatTextFormField(
                label: "Password",
                controller: controller.passwordController,
                obscure: controller.obscure,
                validator: (value) {
                  if (value!.length < 6) {
                    return "minimum 6 characters";
                  }
                  return null;
                },
                suffix: IconButton(
                  onPressed: () => controller.changeObscure(),
                  icon: Icon(
                    controller.obscure
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PhoneSignUpForm extends StatelessWidget {
  const PhoneSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<SignUpCubit>(context).phoneFormKey,
      child: ChatTextFormField(
        label: "",
        controller: BlocProvider.of<SignUpCubit>(context).numberController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if(value!.isEmpty){
            return "Enter valid phone number";
          }
          return null;
        },
      ),
    );
  }
}
