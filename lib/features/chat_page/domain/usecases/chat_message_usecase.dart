import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/domain/repositories/chat_messages_repository.dart';
import 'package:dartz/dartz.dart';

class SendChatMessagesUseCase extends UseCase<void, List<String>> {
  final ChatMessagesReopsitory chatMessagesReopsitory;

  SendChatMessagesUseCase({required this.chatMessagesReopsitory});
  @override
  Future<Either<Failure, void>> call(List<String> params) =>
      chatMessagesReopsitory.sendMessage(
        senderId: params[0],
        receiverId: params[1],
        dateTime: params[2],
        message: params[3],
      );
}

class GetChatMessagesUseCase extends UseCase<List<Chat>, List<String>> {
  final ChatMessagesReopsitory chatMessagesReopsitory;

  GetChatMessagesUseCase({required this.chatMessagesReopsitory});
  @override
  Future<Either<Failure, List<Chat>>> call(List<String> params) =>
      chatMessagesReopsitory.getMessages(
        senderId: params[0],
        receiverId: params[1],
      );
}
