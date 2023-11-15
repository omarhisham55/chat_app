part of 'welcome_page_cubit.dart';

abstract class WelcomePageState extends Equatable {
  const WelcomePageState();

  @override
  List<Object> get props => [];
}

class WelcomePageInitial extends WelcomePageState {}

class LoadingGetSavedUserState extends WelcomePageState {}

class GetSavedUserSuccessState extends WelcomePageState {
  final User? userModel;

  const GetSavedUserSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel ?? "No saved User"];
}

class GetSavedUserErrorState extends WelcomePageState {
  final String msg;

  const GetSavedUserErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class LoadingGetAllUsersState extends WelcomePageState {}

class GetAllUsersSuccessState extends WelcomePageState {
  final List<User>? userModel;

  const GetAllUsersSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel ?? "No User found"];
}

class GetAllUsersErrorState extends WelcomePageState {
  final String msg;

  const GetAllUsersErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
