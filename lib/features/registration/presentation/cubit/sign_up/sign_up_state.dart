part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class ChangeObscure extends SignUpState {
  final bool obscure;
  const ChangeObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

class LoadingCreateUserState extends SignUpState {}

class CreateUserSuccessState extends SignUpState {
  final String userModel;

  const CreateUserSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class CreateUserErrorState extends SignUpState {
  final String msg;

  const CreateUserErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
