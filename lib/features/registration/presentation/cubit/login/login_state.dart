part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class ChangeObscure extends LoginState {
  final bool obscure;
  const ChangeObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

class LoadingGetUserState extends LoginState {}

class GetUserSuccessState extends LoginState {
  final User userModel;

  const GetUserSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class GetUserErrorState extends LoginState {
  final String msg;

  const GetUserErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
