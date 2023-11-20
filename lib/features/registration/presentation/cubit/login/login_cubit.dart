import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/registration/domain/usecases/get_user.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GetUserUsecase getUserUsecase;
  LoginCubit({required this.getUserUsecase}) : super(LoginInitial());

  LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscure = false;
  void changeObscure() {
    obscure = !obscure;
    emit(ChangeObscure(obscure));
  }

  Future<void> userLogin(context) async {
    emit(LoadingGetUserState());
    Either<Failure, User> response = await getUserUsecase.call([
      emailController.text,
      passwordController.text,
    ]);
    emit(response.fold(
      (failure) => const GetUserErrorState(msg: "get user failed"),
      (success) {
        BlocProvider.of<WelcomePageCubit>(context).userModel = success;
        BlocProvider.of<WelcomePageCubit>(context).allUsers.remove(success);
        return GetUserSuccessState(userModel: success);
      },
    ));
  }
}
