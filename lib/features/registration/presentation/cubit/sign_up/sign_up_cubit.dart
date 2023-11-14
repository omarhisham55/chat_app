import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/registration/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final CreateUserByEmailUseCase createUserByEmail;
  final CreateUserByPhoneNumberUseCase createUserByPhoneNumber;
  final SendSmsUseCase sendSmsUseCase;
  SignUpCubit({
    required this.createUserByEmail,
    required this.createUserByPhoneNumber,
    required this.sendSmsUseCase,
  }) : super(SignUpInitial());

  SignUpCubit get(context) => BlocProvider.of<SignUpCubit>(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  List<TextEditingController> otps =
      List.generate(6, (index) => TextEditingController());

  bool obscure = false;
  void changeObscure() {
    obscure = !obscure;
    emit(ChangeObscure(obscure));
  }

  Future<void> createUserAccountByEmail() async {
    emit(LoadingCreateUserState());
    Either<Failure, dynamic> response = await createUserByEmail.call([
      usernameController.text,
      emailController.text,
      passwordController.text,
    ]);
    emit(
      response.fold(
        (failure) => const CreateUserErrorState(
          msg: "create user failed",
        ),
        (created) => const CreateUserSuccessState(
          userModel: "create user success",
        ),
      ),
    );
  }

  int counter = 60;
  resendCode(Function() timer) {
    counter = 60;
    timer();
  }

  Future<void> createUserAccountByPhoneNumber() async {
    final Either<Failure, void> response =
        await createUserByPhoneNumber.call(numberController.text);
    emit(
      response.fold(
        (failure) => PhoneAuthenticationErrorState(),
        (success) => PhoneAuthenticationSuccessState(),
      ),
    );
  }

  Future sendSmsCode() async {
    String otp = "";
    for (TextEditingController value in otps) {
      otp += value.text;
    }
    final Either<Failure, dynamic> sms = await sendSmsUseCase.call(otp);
    emit(
      sms.fold(
        (l) => CodeNotVerifiedState(),
        (r) => CodeVerifiedState(),
      ),
    );
  }
}
