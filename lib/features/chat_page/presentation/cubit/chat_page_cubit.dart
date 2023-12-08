import 'package:audioplayers/audioplayers.dart';
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
  final AddToArchiveUsecase addToArchiveUsecase;
  ChatPageCubit({
    required this.chatMessagesUseCase,
    required this.getChatMessagesUseCase,
    required this.addToArchiveUsecase,
  }) : super(ChatPageInitial());

  TextEditingController messageController = TextEditingController();

  Future<void> sendChat({
    required BuildContext context,
    required String receiverId,
  }) async {
    if (messageController.text.isNotEmpty) {
      final response = await chatMessagesUseCase.call([
        SplashScreenCubit.userModel!.id,
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

  late Map<String, Map<String, dynamic>> messages = {
    for (var key in SplashScreenCubit.allUsers!)
      key.id: {
        "allMessages": <Chat>[],
        "lastMessageText": "",
        "lastMessageDate": "",
      }
  };

  Stream<dynamic> getChat({
    required BuildContext context,
    required String receiverId,
  }) async* {
    final response = await getChatMessagesUseCase.call([
      SplashScreenCubit.userModel!.id,
      receiverId,
    ]);
    emit(
      response.fold(
        (l) => const GetChatFailed(),
        (r) {
          r.forEach((e) {
            messages[receiverId]!["allMessages"] = e;
          });
          return GetChatSuccess(
            msg: messages[receiverId]!["allMessages"].isEmpty
                ? ""
                : messages[receiverId]!["allMessages"].last.message,
          );
        },
      ),
    );
    yield messages[receiverId]!["allMessages"];
  }

  Future getAllChatMessages(context) async {
    try {
      final List<User> users = SplashScreenCubit.allUsers!;
      for (var userId in users) {
        await getChat(
          context: context,
          receiverId: userId.id,
        ).last.then((value) {
          if (value.last.receiverId == userId.id ||
              value.last.senderId == userId.id) {
            messages[userId.id]!["lastMessageText"] = value.last.message;
            messages[userId.id]!["lastMessageDate"] = value.last.dateTime;
          }
        });
        emit(GetChatSuccess(msg: messages[userId.id]!["lastMessageText"]));
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  List<User> selectedChatList = [];
  late List<bool> chatBackgroundColor = List.generate(
    SplashScreenCubit.allUsers!.length,
    (index) => false,
  );
  void selectedChat(int index, User user) {
    if (selectedChatList.contains(user)) {
      return;
    } else {
      chatBackgroundColor[index] = true;
      selectedChatList.add(user);
    }
    emit(SelectedChatState(list: selectedChatList.length));
  }

  void removeSelectedChat(int index, User user) {
    if (selectedChatList.contains(user)) {
      chatBackgroundColor[index] = false;
      selectedChatList.remove(user);
    } else {
      chatBackgroundColor[index] = true;
      selectedChatList.add(user);
    }

    emit(SelectedChatState(list: selectedChatList.length));
  }

  void clearAllSelectedChat() {
    selectedChatList.clear();
    for (int i = 0; i < chatBackgroundColor.length; i++) {
      chatBackgroundColor[i] = false;
    }
    emit(const SelectedChatState(list: 0));
  }

  List<User> archived = [];
  Future<void> addToArchive() async {
    // archived = selectedChatList;
    final response = await addToArchiveUsecase.call(selectedChatList);
    response.fold(
      (l) => const AddToArchiveFailed(),
      (r) async {
        clearAllSelectedChat();
        return AddToArchiveSuccess(await r);
      },
    );
  }
}
