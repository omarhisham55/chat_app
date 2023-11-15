import 'dart:async';

import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/widgets/buttons.dart';
import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/registration/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (BlocProvider.of<SignUpCubit>(context).counter > 0) {
          BlocProvider.of<SignUpCubit>(context).counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

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
                  Row(
                    children: [
                      RoundedButton(
                        text: "resend code",
                        isButtonSmall: true,
                        onPressed: () {
                          if (BlocProvider.of<SignUpCubit>(context).counter ==
                              0) {
                            BlocProvider.of<SignUpCubit>(context)
                                .resendCode(() => _startTimer());
                          }
                        },
                        backgroundColor:
                            BlocProvider.of<SignUpCubit>(context).counter == 0
                                ? null
                                : AppColors.shadedColor,
                      ),
                      const Spacer(),
                      Text(
                        BlocProvider.of<SignUpCubit>(context)
                            .counter
                            .toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "Verify",
              onPressed: () => BlocProvider.of<SignUpCubit>(context).sendSmsCode(),
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
                if (value.length == 1) {
                  FocusScope.of(_).nextFocus();
                }
                if (value.isEmpty) {
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
