import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/domain/usecases/chat_message_usecase.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_page_state.dart';

class ChatPageCubit extends Cubit<ChatPageState> {
  final SendChatMessagesUseCase chatMessagesUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  List<Chat> messages = [];
  ChatPageCubit({
    required this.chatMessagesUseCase,
    required this.getChatMessagesUseCase,
  }) : super(ChatPageInitial());

  TextEditingController messageController = TextEditingController();

  Future<void> sendChat({
    required BuildContext context,
    required String receiverId,
  }) async {
    if (messageController.text.isNotEmpty) {
      final response = await chatMessagesUseCase.call([
        BlocProvider.of<SplashScreenCubit>(context).userModel!.id,
        receiverId,
        DateTime.now().toString(),
        messageController.text,
      ]);
      messageController.clear();
      emit(
        response.fold(
          (failure) => const SendChatFailed(),
          (success) => const SendChatSuccess("sent"),
        ),
      );
    }
  }

  Stream<List<Chat>> getChat({
    required BuildContext context,
    required String receiverId,
  }) async* {
    final response = await getChatMessagesUseCase.call([
      BlocProvider.of<SplashScreenCubit>(context).userModel!.id,
      receiverId,
    ]);
    emit(
      response.fold(
        (l) => const GetChatFailed(),
        (r) {
          r.forEach((e) {
            messages = e;
          });
          return GetChatSuccess(DateTime.now().millisecond);
        },
      ),
    );
    yield messages;
  }

  void getAllChatMessages(context) {
    for (int i = 0;
        i < BlocProvider.of<SplashScreenCubit>(context).allUsers.length - 1;
        i++) {
      BlocProvider.of<ChatPageCubit>(context).getChat(
        context: context,
        receiverId: BlocProvider.of<SplashScreenCubit>(context).allUsers[i].id,
      );
      print('sha8al');
    }
  }

  List<User> selectedChatList = [];
  List<Color> chatBackgroundColor(context) => List.generate(
      BlocProvider.of<SplashScreenCubit>(context).allUsers.length,
      (index) => AppColors.whiteBackgroundColor);
  void selectedChat(BuildContext context, int index, User user) {
    if (selectedChatList.contains(user)) {
      chatBackgroundColor(context)[index] = AppColors.whiteBackgroundColor;
      selectedChatList.remove(user);
    } else {
      chatBackgroundColor(context)[index] = AppColors.lightThemePrimaryColor;
      selectedChatList.add(user);
    }
    emit(SelectedChatState(list: selectedChatList.length));
  }
}
