part of 'splash_screen_cubit.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState {}

class LoadingGetSavedUserState extends SplashScreenState {}

class GetSavedUserSuccessState extends SplashScreenState {
  final User? userModel;

  const GetSavedUserSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel ?? "No saved User"];
}

class GetSavedUserErrorState extends SplashScreenState {
  final String msg;

  const GetSavedUserErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class LoadingGetAllUsersState extends SplashScreenState {}

class GetAllUsersSuccessState extends SplashScreenState {
  final List<User>? userModel;

  const GetAllUsersSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel ?? "No User found"];
}

class GetAllUsersErrorState extends SplashScreenState {
  final String msg;

  const GetAllUsersErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
