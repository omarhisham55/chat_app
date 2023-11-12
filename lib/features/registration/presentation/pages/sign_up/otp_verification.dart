import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Verification Code",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  _otpCode(context),
                  RoundedButton(
                    text: "resend code",
                    isButtonSmall: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "Verify",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpCode(_) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: List.generate(
          6,
          (index) => Expanded(
            child: ChatTextFormField(
              label: "",
              controller: BlocProvider.of<SignUpCubit>(_).otps[index],
              validator: (value) => null,
              maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                if(value.length == 1){
                  FocusScope.of(_).nextFocus();
                }
                if(value.isEmpty){
                  FocusScope.of(_).previousFocus();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
