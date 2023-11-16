import 'package:chat_app/features/chat_page/domain/usecases/chat_message_usecase.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_page_state.dart';

class ChatPageCubit extends Cubit<ChatPageState> {
  ChatMessagesUseCase chatMessagesUseCase;
  ChatPageCubit({required this.chatMessagesUseCase}) : super(ChatPageInitial());

  TextEditingController messageController = TextEditingController();

  Future<void> sendChat({
    required BuildContext context,
    required String receiverId,
  }) async {
    final response = await chatMessagesUseCase.call([
      BlocProvider.of<WelcomePageCubit>(context).userModel!.id,
      receiverId,
      "${DateTime.now().hour}: ${DateTime.now().minute}",
      messageController.text,
    ]);
    emit(
      response.fold(
        (failure) => const SendChatFailed(),
        (success) => const SendChatSuccess("sent"),
      ),
    );
  }
}
