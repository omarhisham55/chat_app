import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/domain/usecases/chat_message_usecase.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        BlocProvider.of<WelcomePageCubit>(context).userModel!.id,
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
      BlocProvider.of<WelcomePageCubit>(context).userModel!.id,
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
}
