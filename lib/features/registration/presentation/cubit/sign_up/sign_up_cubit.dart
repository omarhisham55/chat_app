import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/registration/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final CreateUser createUser;
  SignUpCubit({required this.createUser}) : super(SignUpInitial());

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

  Future<void> createUserAccount() async {
    emit(LoadingCreateUserState());
    Either<Failure, dynamic> response = await createUser.call([
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
}
