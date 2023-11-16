import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/registration/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'welcome_page_state.dart';

class WelcomePageCubit extends Cubit<WelcomePageState> {
  GetSavedUserUsecase getSavedUserUsecase;
  GetAllUsersUsecase getAllUsersUsecase;
  User? userModel;
  List<User> allUsers = [];
  WelcomePageCubit({
    required this.getSavedUserUsecase,
    required this.getAllUsersUsecase,
  }) : super(WelcomePageInitial());

  Future getSavedUser() async {
    emit(LoadingGetSavedUserState());
    Either<Failure, User?> response = await getSavedUserUsecase.call(
      NoParams(),
    );
    emit(response.fold(
      (failure) => const GetSavedUserErrorState(msg: "get saved user error"),
      (success) {
        userModel = success;
        return GetSavedUserSuccessState(userModel: success);
      },
    ));
  }

  Future getAllUsers() async {
    emit(LoadingGetAllUsersState());
    Either<Failure, List<User>> response =
        await getAllUsersUsecase.call(NoParams());
    emit(
      response.fold(
        (l) => GetAllUsersErrorState(msg: l.toString()),
        (users) {
          allUsers = users;
          return GetAllUsersSuccessState(userModel: users);
        },
      ),
    );
  }
}
