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
  WelcomePageCubit({required this.getSavedUserUsecase})
      : super(WelcomePageInitial());

  Future getSavedUser() async {
    emit(LoadingGetSavedUserState());
    Either<Failure, User?> response = await getSavedUserUsecase.call(
      NoParams(),
    );
    emit(response.fold(
      (failure) => const GetSavedUserErrorState(msg: "get saved user error"),
      (success) => GetSavedUserSuccessState(userModel: success),
    ));
  }
}
